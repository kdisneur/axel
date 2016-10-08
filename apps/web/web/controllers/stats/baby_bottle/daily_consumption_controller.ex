defmodule Web.Stats.BabyBottle.DailyConsumptionController do
  use Web.Web, :controller

  def show(conn, %{"id" => date}) do
    case Ecto.Date.cast(date) do
      {:ok, date} ->
        consumption = Business.BabyBottle.daily_consumption(date)

        render(conn, "show.json", data: {date, consumption})
      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Web.ErrorView, "error.json", message: "Parameters should be a valid date")
    end
  end
end
