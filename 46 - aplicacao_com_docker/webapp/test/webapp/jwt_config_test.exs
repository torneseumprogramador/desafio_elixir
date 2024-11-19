defmodule Webapp.JWTConfigTest do
  use ExUnit.Case, async: true

  alias Webapp.JWTConfig

  setup do
    # Configura uma chave secreta de teste
    Application.put_env(:webapp, WebappWeb.Endpoint, jwt_secret: "test_secret_key")

    # Limpa a configuração após o teste
    on_exit(fn ->
      Application.delete_env(:webapp, WebappWeb.Endpoint)
    end)

    :ok
  end

  describe "generate_and_sign/2" do
    test "gera um token JWT com a payload especificada" do
      # Payload de exemplo
      claims = %{"data" => "123456"}

      # Gera o token JWT
      {:ok, token, _claims} = JWTConfig.generate_and_sign(claims, JWTConfig.signer())

      # Verifica se o token é uma string binária
      assert is_binary(token)
    end
  end

  describe "verify_and_validate/2" do
    test "valida o token JWT e recupera a payload se o token for válido" do
      # Payload de exemplo
      claims = %{"data" => "123456"}

      # Gera o token JWT
      {:ok, token, _claims} = JWTConfig.generate_and_sign(claims, JWTConfig.signer())

      # Verifica e valida o token
      case JWTConfig.verify_and_validate(token, JWTConfig.signer()) do
        {:ok, decoded_claims} ->
          assert decoded_claims["data"] == "123456"

        {:error, reason} ->
          flunk("Token não foi validado: #{reason}")
      end
    end

    test "retorna erro se o token for inválido" do
      # Token JWT inválido
      invalid_token = "invalid.token.example"

      # Verifica e valida o token
      assert {:error, _reason} = JWTConfig.verify_and_validate(invalid_token, JWTConfig.signer())
    end
  end
end
