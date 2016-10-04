defmodule Web.ChangesetView do
  use Web.Web, :view

  def render("error.json", %{changeset: changeset}) do
    %{
      errors: Enum.map(changeset.errors, &format_error/1)
    }
  end

  defp format_error({field, {message, options}}) do
    %{
      field: field,
      value: translate_error(message, options)
    }
  end

  defp translate_error(message, options) do
    if count = options[:count] do
      Gettext.dngettext(Web.Gettext, "errors", message, message, count, options)
    else
      Gettext.dgettext(Web.Gettext, "errors", message, options)
    end
  end
end
