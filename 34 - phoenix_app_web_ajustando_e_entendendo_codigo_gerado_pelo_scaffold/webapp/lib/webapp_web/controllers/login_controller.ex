defmodule WebappWeb.LoginController do
  use WebappWeb, :controller

  def index(conn, _params) do
    render(conn, :index, layout: {WebappWeb.Layouts, :login})
  end
end
