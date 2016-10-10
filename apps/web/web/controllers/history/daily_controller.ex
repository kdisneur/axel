defmodule Web.History.DailyController do
  use Web.Web, :controller

  def show(conn, %{"id" => date}) do
    case Ecto.Date.cast(date) do
      {:ok, date} ->
        history =
          Business.BabyBottle.daily_history(date)
          |> Enum.concat(Business.Diaper.daily_history(date))
          |> Enum.sort(fn
                         (s1 = %Business.BabyBottle.Feeding{}, s2 = %Business.BabyBottle.Feeding{}) ->
                           s1.fed_at > s2.fed_at
                         (s1 = %Business.BabyBottle.Feeding{}, s2 = %Business.Diaper.Change{}) ->
                           s1.fed_at > s2.changed_at
                         (s1 = %Business.Diaper.Change{}, s2 = %Business.BabyBottle.Feeding{}) ->
                           s1.changed_at > s2.fed_at
                         (s1 = %Business.Diaper.Change{}, s2 = %Business.Diaper.Change{}) ->
                           s1.changed_at > s2.changed_at
                       end)

        render(conn, "show.json", data: {date, history})
      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Web.ErrorView, "error.json", message: "Parameters should be a valid date")
    end
  end
end
