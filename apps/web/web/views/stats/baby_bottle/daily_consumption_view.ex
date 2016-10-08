defmodule Web.Stats.BabyBottle.DailyConsumptionView do
  use Web.Web, :view

  def render("show.json", %{data: {date, consumption}}) do
    %{
      "date" => date,
      "consumption" => %{
        "quantity" => consumption,
        "unit" => "ml"
      }
    }
  end
end
