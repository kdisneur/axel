defmodule Business.Diaper.Stats do
  import Ecto.Query

  alias Business.Diaper.Change

  def daily_poop_count(date) do
    daily_count(date, :poop)
  end

  def daily_pee_count(date) do
    daily_count(date, :pee)
  end

  def daily_count(date, kind) do
    count =
      Change
      |> where([f], fragment("date(?)", f.changed_at) == ^date)
      |> where([f], field(f, ^kind) == ^true)
      |> select([f], count(field(f, ^kind)))
      |> Business.Repo.one

    case count do
      nil ->
        0
      consumption ->
        consumption
    end
  end
end
