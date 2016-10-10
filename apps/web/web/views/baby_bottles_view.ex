defmodule Web.BabyBottlesView do
  def render("show.json", %{feeding: feeding}) do
    %{
      "type" => "feeding",
      "id" => feeding.id,
      "fed_at" => feeding.fed_at,
      "quantity" => feeding.quantity
    }
  end
end
