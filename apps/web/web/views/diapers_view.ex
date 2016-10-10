defmodule Web.DiapersView do
  def render("show.json", %{change: change}) do
    %{
      "type" => "change",
      "changed_at" => change.changed_at,
      "poop" => change.poop,
      "pee" => change.pee
    }
  end
end
