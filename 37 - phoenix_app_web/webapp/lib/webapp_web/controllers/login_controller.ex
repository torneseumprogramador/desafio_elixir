defmodule WebappWeb.LoginController do
  use WebappWeb, :controller
  alias Webapp.Administradores
  alias Bcrypt
  alias Webapp.JWTConfig

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
