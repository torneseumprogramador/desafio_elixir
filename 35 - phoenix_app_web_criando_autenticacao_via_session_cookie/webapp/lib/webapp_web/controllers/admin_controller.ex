defmodule WebappWeb.AdminController do
  use WebappWeb, :controller
  alias Webapp.Administradores

  def index(conn, params) do
    nome = Map.get(params, "nome", nil)
    administradores = Administradores.list_administradores_by_nome_or_email(nome)
    render(conn, :index, nome: nome, administradores: administradores, layout: {WebappWeb.Layouts, :app})
  end

  def new(conn, _params) do
    render(conn, :new, layout: {WebappWeb.Layouts, :app})
  end

  def edit(conn, %{"id" => id}) do
    administrador = Administradores.get_administrador!(id)

    conn
    |> render(:edit, changeset: nil, administrador: administrador, layout: {WebappWeb.Layouts, :app})
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

  def update(conn, %{"id" => id} = params) do
    administrador = Administradores.get_administrador!(id)

    case Administradores.update_administrador(administrador, params) do
      {:ok, _administrador} ->
        conn
        |> put_flash(:success, "Administrador atualizado com sucesso.")
        |> redirect(to: "/administradores")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Erro ao atualizar o administrador.")
        |> render(:edit, administrador: administrador, changeset: changeset, layout: {WebappWeb.Layouts, :app})
    end
  end


  def delete(conn, %{"id" => id}) do
    case Administradores.delete_administrador_by_id(id) do
      {:ok, _administrador} ->
        conn
        |> put_flash(:info, "Administrador criado com sucesso!")
        |> redirect(to: "/administradores")

      {:error, _} ->
        conn
        |> put_flash(:error, "Erro ao apagar administrador.")
        |> redirect(to: "/administradores")
    end
  end
end
