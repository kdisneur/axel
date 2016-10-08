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
end
