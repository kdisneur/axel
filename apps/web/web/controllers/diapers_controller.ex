defmodule Web.DiapersController do
  use Web.Web, :controller

  def create(conn, params) do
    case Business.Diaper.add(params["changed_at"], {params["poop"], params["pee"]}) do
      {:ok, change} ->
        conn
        |> put_status(:created)
        |> render("show.json", change: change)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Business.Diaper.delete(id) do
      {:ok, change} ->
        render(conn, "show.json", change: change)
      {:error, :not_found} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Web.ErrorView, "error.json", message: "This change doesn't exist")
    end
  end
end
