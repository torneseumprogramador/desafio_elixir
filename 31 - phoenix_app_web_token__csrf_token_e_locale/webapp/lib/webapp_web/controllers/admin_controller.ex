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

  def create(conn, %{"nome" => nome, "email" => email, "senha" => senha}) do
    attrs = %{"nome" => nome, "email" => email, "senha" => senha}

    case Administradores.create_administrador(attrs) do
      {:ok, _administrador} ->
        conn
        |> put_flash(:info, "Administrador criado com sucesso!")
        |> redirect(to: "/administradores")

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Erro ao criar administrador.")
        |> render(:new, changeset: changeset, layout: {WebappWeb.Layouts, :app})
    end
  end
end
