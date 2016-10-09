defmodule Business.Diaper do
  def add(datetime, {poop, pee}) do
    %{changed_at: datetime, poop: poop, pee: pee}
    |> Business.Diaper.Change.changeset
    |> Business.Repo.insert
  end

  def daily_poop_count(date) do
    Business.Diaper.Stats.daily_poop_count(date)
  end

  def daily_pee_count(date) do
    Business.Diaper.Stats.daily_pee_count(date)
  end
end
