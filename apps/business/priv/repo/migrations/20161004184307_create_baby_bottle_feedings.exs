defmodule Business.Repo.Migrations.CreateBabyBottleFeedings do
  use Ecto.Migration

  def change do
    create table(:baby_bottle_feedings) do
      add :fed_at, :datetime
      add :quantity, :integer
    end
  end
end
