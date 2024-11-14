defmodule WebappWeb.Components.Middleware.AuthMiddleware do
  import Plug.Conn
  import Phoenix.Controller
  alias Webapp.JWTConfig

  def init(default), do: default

  def call(conn, _opts) do
    conn = fetch_cookies(conn)

    case conn.cookies["adm_info"] do
      nil ->
        conn
        |> redirect(to: "/")
        |> halt()

      token ->
        case JWTConfig.verify_and_validate(token, JWTConfig.signer()) do
          {:ok, adm_info} ->
            conn
            |> assign(:current_adm, adm_info)

          {:error, _reason} ->
            conn
            |> redirect(to: "/")
            |> halt()
        end
    end
  end
end
