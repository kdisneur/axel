defmodule Business.BabyBottle.Command do
  def delete(id) do
    case Business.BabyBottle.Query.find_by_id(id) do
      nil ->
        {:error, :not_found}
      feeding ->
        Business.Repo.delete(feeding)
    end
  end
end
