defmodule WebappWeb.Components.Middleware.ApiAuthMiddleware do
  import Plug.Conn
  import Phoenix.Controller
  alias Webapp.JWTConfig
  alias DateTime

  def init(default), do: default

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        case JWTConfig.verify_and_validate(token, JWTConfig.signer()) do
          {:ok, adm_info} ->

            if adm_info["data_expiracao"] do
              case DateTime.from_iso8601(adm_info["data_expiracao"]) do
                {:ok, data_expiracao, _} ->
                  hoje = DateTime.utc_now() |> DateTime.shift_zone!("America/Sao_Paulo")

                  data_expiracao = DateTime.shift_zone!(data_expiracao, "America/Sao_Paulo")

                  if DateTime.compare(data_expiracao, hoje) == :gt do
                    assign(conn, :current_adm, adm_info)
                  else
                    conn
                    |> put_status(:unauthorized)
                    |> json(%{error: "Token expirado"})
                    |> halt()
                  end

                {:error, _reason} ->
                  conn
                  |> put_status(:bad_request)
                  |> json(%{error: "Token expirado"})
                  |> halt()
              end
            else
              conn
                |> put_status(:bad_request)
                |> json(%{error: "Token expirado"})
                |> halt()
            end
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
