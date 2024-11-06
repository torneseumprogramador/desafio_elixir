defmodule Webapp.JWTConfig do
  use Joken.Config

  @impl true
  def token_config do
    %{}
  end

  def signer do
    secret_key = Application.get_env(:webapp, WebappWeb.Endpoint)[:jwt_secret]
    Joken.Signer.create("HS256", secret_key)
  end
end
