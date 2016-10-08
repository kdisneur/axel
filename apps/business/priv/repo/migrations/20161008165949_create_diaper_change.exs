defmodule Business.Repo.Migrations.CreateDiaperChange do
  use Ecto.Migration

  def change do
    create table(:diaper_changes) do
      add :changed_at, :datetime
      add :poop, :bool
      add :pee, :bool

      timestamps
    end
  end
end
