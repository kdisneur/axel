defmodule Business.BabyBottle do
  def add(datetime, quantity) do
    %{fed_at: datetime, quantity: quantity}
    |> Business.BabyBottle.Feeding.changeset
    |> Business.Repo.insert
  end
end
