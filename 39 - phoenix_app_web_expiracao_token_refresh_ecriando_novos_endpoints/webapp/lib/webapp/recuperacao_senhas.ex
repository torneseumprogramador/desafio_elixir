defmodule Webapp.RecuperacaoSenhas do
  alias Webapp.Repo
  alias Webapp.RecuperacaoSenhas.RecuperacaoSenha
  alias DateTime

  def all do
    Repo.all(RecuperacaoSenha)
  end

  def create(attrs \\ %{}) do
    %RecuperacaoSenha{}
    |> RecuperacaoSenha.changeset(attrs)
    |> Repo.insert()
  end

  def clear do
    Repo.delete_all(RecuperacaoSenha)
  end

  def delete_by_token(token) do
    case Repo.get_by(RecuperacaoSenha, token: token) do
      nil ->
        {:error, "Token não encontrado"}

      recuperacao_senha ->
        Repo.delete(recuperacao_senha)
    end
  end

  def get_by_token(token) do
    case Repo.get_by(RecuperacaoSenha, token: token) do
      nil ->
        {:error, "Token não encontrado"}

      %RecuperacaoSenha{data_expiracao: data_expiracao} = recuperacao_senha ->
        case DateTime.from_naive(data_expiracao, "Etc/UTC") do
          {:ok, data_expiracao_utc} ->
            if DateTime.compare(data_expiracao_utc, DateTime.utc_now()) == :gt do
              {:ok, recuperacao_senha}
            else
              {:error, "Token expirado"}
            end

          {:error, _reason} ->
            {:error, "Erro ao processar a data de expiração"}
        end
    end
  end
end
