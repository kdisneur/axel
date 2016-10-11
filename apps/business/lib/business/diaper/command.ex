defmodule Business.Diaper.Command do
  def delete(id) do
    case Business.Diaper.Query.find_by_id(id) do
      nil ->
        {:error, :not_found}
      change ->
        Business.Repo.delete(change)
    end
  end
end
