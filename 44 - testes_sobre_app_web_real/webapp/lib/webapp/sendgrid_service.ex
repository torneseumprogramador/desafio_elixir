defmodule Webapp.SendgridService do
  @sendgrid_api_url "https://api.sendgrid.com/v3/mail/send"
  @api_key System.get_env("SENDGRID_API_KEY")

  def enviar_email_recuperacao(email_destino, token) do
    body = %{
      "from" => %{
        "name" => "Suporte",
        "email" => "suporte@torneseumprogramador.com.br"
      },
      "subject" => "Recuperação de Senha",
      "content" => [
        %{
          "type" => "text/plain",
          "value" => "Para redefinir sua senha, acesse o seguinte link: http://localhost:4000/redefinir-senha?token=#{token}"
        },
        %{
          "type" => "text/html",
          "value" => "<p>Para redefinir sua senha, clique no link abaixo:</p><p><a href=\"http://localhost:4000/redefinir-senha?token=#{token}\">Redefinir Senha</a></p>"
        }
      ],
      "personalizations" => [
        %{
          "to" => [%{"email" => email_destino}]
        }
      ]
    }
    |> Jason.encode!()

    headers = [
      {"Authorization", "Bearer #{@api_key}"},
      {"Content-Type", "application/json"}
    ]

    Finch.build(:post, @sendgrid_api_url, headers, body)
    |> Finch.request(Webapp.Finch)
    |> handle_response()
  end

  defp handle_response({:ok, %Finch.Response{status: 202}}) do
    :ok
  end

  defp handle_response({:ok, %Finch.Response{status: status, body: body}}) do
    {:error, "Erro #{status}: #{body}"}
  end

  defp handle_response({:error, reason}) do
    {:error, reason}
  end
end
