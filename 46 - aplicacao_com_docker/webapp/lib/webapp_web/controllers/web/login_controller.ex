defmodule WebappWeb.Controllers.Web.LoginController do
  use WebappWeb, :controller
  alias Webapp.Administradores
  alias Webapp.RecuperacaoSenhas
  alias Bcrypt
  alias Webapp.JWTConfig
  alias Ecto
  alias Webapp.SendgridService

  def index(conn, _params) do
    conn = fetch_cookies(conn)

    case conn.cookies["adm_info"] do
      nil ->
        render(conn, :index, layout: {WebappWeb.Layouts, :login})

      _token ->
        conn
        |> redirect(to: "/dashboard")
        |> halt()
    end
  end

  def forgot_password(conn, _params) do
    render(conn, :forgot_password, layout: {WebappWeb.Layouts, :login})
  end

  def change_password(conn, params) do
    token = Map.get(params, "token", nil)
    if is_nil(token) do
      conn
      |> put_flash(:error, "Token não pode ser em branco")
      |> redirect(to: "/")
    else
      case RecuperacaoSenhas.get_by_token(token) do
        {:ok, token_register} when not is_nil(token_register.token) ->
          render(conn, :change_password, token: token, layout: {WebappWeb.Layouts, :login})
        {:ok, _administrador} ->
          conn
          |> put_flash(:error, "Token não permitido")
          |> redirect(to: "/")

        {:error, _reason} ->
          conn
          |> put_flash(:error, "Token não permitido")
          |> redirect(to: "/")
      end
    end
  end

  def change_password_confirmation(conn, %{"senha" => senha, "csenha" => csenha, "token" => token}) do
    case RecuperacaoSenhas.get_by_token(token) do
      {:ok, token_register} when not is_nil(token_register.token) ->

        administrador = Administradores.get_administrador!(token_register.administrador_id)

        if senha != csenha do
          changeset =
            %Ecto.Changeset{valid?: false, errors: [senha: {"A senha não corresponde à confirmação.", []}]}
          conn
          |> render(:change_password, token: token, changeset: changeset, layout: {WebappWeb.Layouts, :login})
        else
          Administradores.update_administrador(administrador, %{"senha" => senha})
          RecuperacaoSenhas.delete_by_token(token)
          conn
          |> put_flash(:success, "Senha alterada com sucesso!")
          |> redirect(to: "/")
        end

      {:ok, _administrador} ->
        conn
        |> put_flash(:error, "Token não permitido")
        |> redirect(to: "/")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Token não permitido")
        |> redirect(to: "/")
    end
  end

  def forgot_password_email_token(conn, params) do
    email = Map.get(params, "email", nil)
    case Administradores.find_by_email(email) do
      {:ok, administrador} when not is_nil(administrador.id) and not is_nil(administrador.email) ->
        token = Ecto.UUID.generate()
        data_expiracao = DateTime.utc_now() |> DateTime.add(15 * 60, :second) # + 15 minutos
        RecuperacaoSenhas.create(%{administrador_id: administrador.id, data_expiracao: data_expiracao, token: token})

        case SendgridService.enviar_email_recuperacao(administrador.email, token) do
          :ok ->
            conn
            |> put_flash(:success, "E-mail de recuperação enviado com sucesso.")
            |> redirect(to: "/")

          :error ->
            conn
            |> put_flash(:error, "Erro ao enviar o e-mail de recuperação.")
            |> redirect(to: "/esqueceu-senha")
        end
      {:ok, _administrador} ->
        conn
        |> put_flash(:error, "Email não existe em nossa base de dados.")
        |> redirect(to: "/esqueceu-senha")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Email não existe em nossa base de dados.")
        |> redirect(to: "/esqueceu-senha")
    end
  end

  def login(conn, %{"login" => login_params}) do
    case Administradores.find_by_email(login_params["email"]) do
      {:ok, administrador} when not is_nil(administrador.senha_hash) ->
        if Bcrypt.verify_pass(login_params["senha"], administrador.senha_hash) do
          max_age = if login_params["mais_tempo"], do: 60 * 60 * 24 * 365, else: 60 * 60 * 24

          adm_info = %{
            id: administrador.id,
            nome: administrador.nome,
            email: administrador.email
          }

          {:ok, token, _claims} = JWTConfig.generate_and_sign(adm_info, JWTConfig.signer())

          conn
          |> put_session(:user_id, administrador.id)
          |> configure_session(renew: true)
          |> put_resp_cookie("adm_info", token, max_age: max_age, http_only: true)
          |> redirect(to: "/dashboard")
        else
          conn
          |> put_flash(:error, "Email ou senha inválidos.")
          |> redirect(to: "/")
        end

      {:ok, _administrador} ->
        conn
        |> put_flash(:error, "Email ou senha inválidos.")
        |> redirect(to: "/")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Email ou senha inválidos.")
        |> redirect(to: "/")
    end
  end

  def logout(conn, _params) do
    conn
    |> delete_resp_cookie("adm_info")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

end
