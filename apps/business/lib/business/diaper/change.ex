defmodule Business.Diaper.Change do
  use Ecto.Schema
  import Ecto.Changeset

  schema "diaper_changes" do
    field :changed_at, Ecto.DateTime
    field :poop, :boolean
    field :pee, :boolean

    timestamps
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:changed_at, :poop, :pee])
    |> validate_required([:changed_at, :poop, :pee])
  end
end
