defmodule WebappWeb.Controllers.Web.FornecedorHTML do
  use WebappWeb, :html

  embed_templates "fornecedor_html/*"

  @doc """
  Renders a fornecedor form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def fornecedor_form(assigns)
end
