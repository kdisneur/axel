defmodule Web.BabyBottlesView do
  def render("show.json", %{feeding: feeding}) do
    %{
      "fed_at" => feeding.fed_at,
      "quantity" => feeding.quantity
    }
  end
end
