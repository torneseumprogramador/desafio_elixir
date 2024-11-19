defmodule WebappWeb.Controllers.Web.AdminController do
  use WebappWeb, :controller
  alias Webapp.Administradores
  alias Webapp.JWTConfig

  def index(conn, params) do
    nome = Map.get(params, "nome", nil)
    administradores = Administradores.list_administradores_by_nome_or_email(nome)
    render(conn, :index, nome: nome, administradores: administradores, layout: {WebappWeb.Layouts, :app})
  end

  def new(conn, _params) do
    render(conn, :new, layout: {WebappWeb.Layouts, :app})
  end

  def register(conn, _params) do
    render(conn, :register, layout: {WebappWeb.Layouts, :login})
  end

  def register_create(conn, %{"nome" => nome, "email" => email, "senha" => senha, "csenha" => csenha}) do
    # Verificação se a senha e a confirmação da senha coincidem
    if senha != csenha do
      # Cria um changeset manualmente com um erro de senha
      changeset =
        %Ecto.Changeset{valid?: false, errors: [senha: {"A senha não corresponde à confirmação.", []}]}

      conn
      |> render(:register, changeset: changeset, layout: {WebappWeb.Layouts, :login})
    else
      # Caso as senhas coincidam, prossiga com a criação do administrador
      attrs = %{"nome" => nome, "email" => email, "senha" => senha}

      case Administradores.create_administrador(attrs) do
        {:ok, administrador} ->
          adm_info = %{
            id: administrador.id,
            nome: administrador.nome,
            email: administrador.email
          }

          max_age = 60 * 60 * 24 # 1 dia

          {_ok, token, _claims} = JWTConfig.generate_and_sign(adm_info, JWTConfig.signer())

          conn
          |> put_session(:user_id, administrador.id)
          |> configure_session(renew: true)
          |> put_resp_cookie("adm_info", token, max_age: max_age, http_only: true)
          |> redirect(to: "/dashboard")

        {:error, changeset} ->
          conn
          |> render(:register, changeset: changeset, layout: {WebappWeb.Layouts, :login})
      end
    end
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
        |> put_flash(:info, "Administrador apagado com sucesso!")
        |> redirect(to: "/administradores")

      {:error, _} ->
        conn
        |> put_flash(:error, "Erro ao apagar administrador.")
        |> redirect(to: "/administradores")
    end
  end
end
