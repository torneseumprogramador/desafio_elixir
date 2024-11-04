defmodule Webapp.RecuperacaoSenhas.RecuperacaoSenha do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recuperacoes_senha" do
    field :token, :string
    field :data_expiracao, :naive_datetime
    field :administrador_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(recuperacao_senha, attrs) do
    recuperacao_senha
    |> cast(attrs, [:token, :data_expiracao, :administrador_id])
    |> validate_required([:token, :data_expiracao, :administrador_id])
  end
end
