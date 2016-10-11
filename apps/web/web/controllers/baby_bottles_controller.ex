defmodule Web.BabyBottlesController do
  use Web.Web, :controller

  def create(conn, params) do
    case Business.BabyBottle.add(params["fed_at"], params["quantity"]) do
      {:ok, feeding} ->
        conn
        |> put_status(:created)
        |> render("show.json", feeding: feeding)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Business.BabyBottle.delete(id) do
      {:ok, feeding} ->
        render(conn, "show.json", feeding: feeding)
      {:error, :not_found} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Web.ErrorView, "error.json", message: "This feeding doesn't exist")
    end
  end
end
