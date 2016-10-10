defmodule Web.History.DailyController do
  use Web.Web, :controller

  def show(conn, %{"id" => date}) do
    case Ecto.Date.cast(date) do
      {:ok, date} ->
        history = Business.BabyBottle.daily_history(date) ++ Business.Diaper.daily_history(date)

        render(conn, "show.json", data: {date, history})
      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Web.ErrorView, "error.json", message: "Parameters should be a valid date")
    end
  end
end
