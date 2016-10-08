defmodule Web.ErrorView do
  use Web.Web, :view

  def render("error.json", %{message: message}) do
    %{
      "errors" => [
        %{"global" => message}
      ]
    }
  end
end
