defmodule Web.Stats.DailyConsumptionView do
  use Web.Web, :view

  def render("show.json", %{data: {date, {baby_bottle_consumption, poop_count, pee_count}}}) do
    %{
      "date" => date,
      "baby_bottle" => %{
        "quantity" => baby_bottle_consumption,
        "unit" => "ml"
      },
      "poop" => %{
        "quantity" => poop_count,
        "unit" => "diaper"
      },
      "pee" => %{
        "quantity" => pee_count,
        "unit" => "diaper"
      }
    }
  end
end
