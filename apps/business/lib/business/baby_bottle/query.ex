defmodule Business.BabyBottle.Query do
  import Ecto.Query

  alias Business.BabyBottle.Feeding

  def all_by_date(date) do
    Feeding
    |> where([f], fragment("date(?)", f.fed_at) == ^date)
    |> order_by([f], desc: f.fed_at)
    |> Business.Repo.all
  end
end
