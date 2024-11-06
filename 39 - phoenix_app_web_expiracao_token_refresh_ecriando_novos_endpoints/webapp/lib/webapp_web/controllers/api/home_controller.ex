defmodule WebappWeb.Controllers.Api.HomeController do
  use WebappWeb, :controller

  def index(conn, _params) do
    json(conn, %{
      message: "Bem vindo a API com Phoenix em Elixir feito no desafio do torne-se um programador"
    })
  end
end
