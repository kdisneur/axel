defmodule Web.Stats.DailyConsumptionController do
  use Web.Web, :controller

  def show(conn, %{"id" => date}) do
    case Ecto.Date.cast(date) do
      {:ok, date} ->
        baby_bottle_consumption = Business.BabyBottle.daily_consumption(date)
        poop_count = Business.Diaper.daily_poop_count(date)
        pee_count = Business.Diaper.daily_pee_count(date)

        render(conn, "show.json", data: {date, {baby_bottle_consumption, poop_count, pee_count}})
      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Web.ErrorView, "error.json", message: "Parameters should be a valid date")
    end
  end
end
