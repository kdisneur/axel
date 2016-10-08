defmodule Business.BabyBottle do
  def add(datetime, quantity) do
    %{fed_at: datetime, quantity: quantity}
    |> Business.BabyBottle.Feeding.changeset
    |> Business.Repo.insert
  end

  def daily_consumption(date) do
    Business.BabyBottle.Stats.daily_consumption(date)
  end
end
