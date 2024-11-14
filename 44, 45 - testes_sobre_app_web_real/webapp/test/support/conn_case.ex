defmodule WebappWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Importa as funções necessárias para testes de conexão HTTP
      import Plug.Conn
      import Phoenix.ConnTest
      alias WebappWeb.Router.Helpers, as: Routes

      # Define o endpoint padrão para testes
      @endpoint WebappWeb.Endpoint

      # Importa funções úteis para manipulação de dados
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import WebappWeb.ConnCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Webapp.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Webapp.Repo, {:shared, self()})
    end

    # Inicializa uma nova conexão para cada teste
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
