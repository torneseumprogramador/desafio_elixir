defmodule WebappWeb.Controllers.Api.HomeController do
  use WebappWeb, :controller

  def index(conn, _params) do
    json(conn, %{
      message: "Bem vindo a API com Phoenix em Elixir feito no desafio do torne-se um programador",
      swagger_json: "/public/swagger.json",
      instrucao_doc: "Acesse a url da doc, coloque o conteúdo do swagger.json",
      doc: "https://editor.swagger.io/"
    })
  end
end
