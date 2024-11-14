defmodule WebappWeb.Controllers.Api.FallbackController do
  use WebappWeb, :controller

  def call(conn, _) do
    conn
    |> put_status(:not_found)
    |> json(%{error: "Rota não encontrada"})
    |> halt()
  end
end
