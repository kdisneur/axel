defmodule Business.Diaper do
  def add(datetime, {poop, pee}) do
    %{changed_at: datetime, poop: poop, pee: pee}
    |> Business.Diaper.Change.changeset
    |> Business.Repo.insert
  end
end
