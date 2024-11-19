defmodule Webapp.JWTConfig do
  use Joken.Config

  @impl true
  def token_config do
    %{}
  end

  def signer do
    secret_key = Application.get_env(:webapp, WebappWeb.Endpoint)[:jwt_secret]

    if is_binary(secret_key) do
      Joken.Signer.create("HS256", secret_key)
    else
      Joken.Signer.create("HS256", "test_secret_key")
    end
  end
end
