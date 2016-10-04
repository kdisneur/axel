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
end
