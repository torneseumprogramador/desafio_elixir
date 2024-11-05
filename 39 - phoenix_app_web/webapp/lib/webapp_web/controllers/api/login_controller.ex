defmodule WebappWeb.Controllers.Api.LoginController do
  use WebappWeb, :controller
  alias Webapp.Administradores
  alias Bcrypt
  alias Webapp.JWTConfig

  def login(conn, %{"email" => email, "senha" => senha}) do
    case Administradores.find_by_email(email) do
      {:ok, administrador} when not is_nil(administrador.senha_hash) ->
        if Bcrypt.verify_pass(senha, administrador.senha_hash) do
          adm_info = %{
            id: administrador.id,
            nome: administrador.nome,
            email: administrador.email
          }

          {:ok, token, _claims} = JWTConfig.generate_and_sign(adm_info, JWTConfig.signer())

          conn
          |> put_status(:ok)
          |> json(%{token: token})
          |> halt()
        else
          conn
          |> put_status(:bad_request)
          |> json(%{error: "Email ou senha inválidos"})
          |> halt()
        end

      {:ok, _administrador} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Email ou senha inválidos"})
        |> halt()

      {:error, _reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Email ou senha inválidos"})
        |> halt()
    end
  end
end
