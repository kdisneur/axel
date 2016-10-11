defmodule Business.BabyBottle do
  def add(datetime, quantity) do
    %{fed_at: datetime, quantity: quantity}
    |> Business.BabyBottle.Feeding.changeset
    |> Business.Repo.insert
  end

  def daily_consumption(date) do
    Business.BabyBottle.Stats.daily_consumption(date)
  end

  def daily_history(date) do
    Business.BabyBottle.Query.all_by_date(date)
  end

  def delete(id) do
    Business.BabyBottle.Command.delete(id)
  end
end
