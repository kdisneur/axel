defmodule Web.History.DailyView do
  def render("show.json", %{data: {date, history}}) do
    %{
      "date" => date,
      "history" => Enum.map(history, &to_json/1)
    }
  end

  defp to_json(change = %Business.Diaper.Change{}) do
    Web.DiapersView.render("show.json", %{change: change})
  end
  defp to_json(feeding = %Business.BabyBottle.Feeding{}) do
    Web.BabyBottlesView.render("show.json", %{feeding: feeding})
  end
end
