defmodule Webapp.SendgridService do
  import Swoosh.Email

  alias Webapp.Mailer

  def enviar_email_recuperacao(email_destino, token) do
    email =
      new()
      |> to(email_destino)
      |> from({"Suporte", "suporte@torneseumprogramador.com.br"})
      |> subject("Recuperação de Senha")
      |> html_body("<p>Para redefinir sua senha, clique no link abaixo:</p>
                    <p><a href=\"http://localhost:4000/redefinir-senha?token=#{token}\">Redefinir Senha</a></p>")
      |> text_body("Para redefinir sua senha, acesse o seguinte link: http://localhost:4000/redefinir-senha?token=#{token}")

    case Mailer.deliver(email) do
      {:ok, _response} ->
        :ok

      {:error, reason} ->
        IO.inspect(reason, label: "Erro ao enviar e-mail")
        :error
    end
  end
end
