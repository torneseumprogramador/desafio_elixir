defmodule WebappWeb.AdminController do
  use WebappWeb, :controller
  alias Webapp.Administradores

  def index(conn, _params) do
    administradores = Administradores.list_administradores()
    render(conn, :index, administradores: administradores, layout: {WebappWeb.Layouts, :app})
  end

  def new(conn, _params) do
    render(conn, :new, layout: {WebappWeb.Layouts, :app})
  end
end
