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
            email: administrador.email,
            data_expiracao: data_expiracao_brasilia()
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

  def new_token(conn, _params) do
    current_adm = conn.assigns.current_adm

    adm_info = %{
      id: current_adm["id"],
      nome: current_adm["nome"],
      email: current_adm["email"],
      data_expiracao: data_expiracao_brasilia()
    }

    {:ok, token, _claims} = JWTConfig.generate_and_sign(adm_info, JWTConfig.signer())

    conn
    |> put_status(:ok)
    |> json(%{token: token})
    |> halt()
  end

  defp data_expiracao_brasilia() do
    data_expiracao = DateTime.add(DateTime.utc_now(), 8 * 3600, :second) # 8 horas para frente
    DateTime.shift_zone!(data_expiracao, "America/Sao_Paulo")
  end
end
