defmodule ProjetoWebWeb.PageController do
  use ProjetoWebWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    mensagem = LibAulaMix.mensagem("Danilo")
    render(conn, :home, layout: false, mensagem: mensagem)
  end
end
