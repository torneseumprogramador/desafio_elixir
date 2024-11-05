defmodule WebappWeb.Components.Middleware.ApiAuthMiddleware do
  import Plug.Conn
  import Phoenix.Controller
  alias Webapp.JWTConfig

  def init(default), do: default

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        case JWTConfig.verify_and_validate(token, JWTConfig.signer()) do
          {:ok, adm_info} ->
            assign(conn, :current_adm, adm_info)

          {:error, _reason} ->
            conn
            |> put_status(:unauthorized)
            |> json(%{error: "Token inválido ou expirado"})
            |> halt()
        end

      _ ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Autenticação necessária"})
        |> halt()
    end
  end
end
