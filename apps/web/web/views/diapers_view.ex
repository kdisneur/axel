defmodule Web.DiapersView do
  def render("show.json", %{change: change}) do
    %{
      "type" => "change",
      "id" => change.id,
      "changed_at" => change.changed_at,
      "poop" => change.poop,
      "pee" => change.pee
    }
  end
end
