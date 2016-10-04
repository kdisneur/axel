defmodule Business.BabyBottle.Feeding do
  use Ecto.Schema
  import Ecto.Changeset

  schema "baby_bottle_feedings" do
    field :fed_at, Ecto.DateTime
    field :quantity, :integer
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:fed_at, :quantity])
    |> validate_required([:fed_at, :quantity])
    |> validate_number(:quantity, greater_than: 0)
  end
end
