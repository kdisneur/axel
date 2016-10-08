defmodule Business.BabyBottle.Stats do
  import Ecto.Query

  alias Business.BabyBottle.Feeding

  def daily_consumption(date) do
    consumption =
      Feeding
      |> where([f], fragment("date(?)", f.fed_at) == ^date)
      |> select([f], sum(f.quantity))
      |> Business.Repo.one

    case consumption do
      nil ->
        0
      consumption ->
        consumption
    end
  end
end
