defmodule WebappWeb.Controllers.Api.ErrorJSON do
  def render("500.json", _assigns) do
    %{errors: %{detail: "Erro interno do servidor"}}
  end

  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
