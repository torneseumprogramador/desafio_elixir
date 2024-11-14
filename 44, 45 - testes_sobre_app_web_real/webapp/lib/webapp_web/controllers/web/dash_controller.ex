defmodule WebappWeb.Controllers.Web.DashController do
  use WebappWeb, :controller

  def index(conn, _params) do
    render(conn, :index, layout: {WebappWeb.Layouts, :app})
  end
end
