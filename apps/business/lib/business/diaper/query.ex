defmodule Business.Diaper.Query do
  import Ecto.Query

  alias Business.Diaper.Change

  def all_by_date(date) do
    Change
    |> where([f], fragment("date(?)", f.changed_at) == ^date)
    |> order_by([f], desc: f.changed_at)
    |> Business.Repo.all
  end
end
