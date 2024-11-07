defmodule Webapp.Fornecedores.Fornecedor do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :nome, :observacao]}
  schema "fornecedores" do
    field :nome, :string
    field :observacao, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(fornecedor, attrs) do
    fornecedor
    |> cast(attrs, [:nome, :observacao])
    |> validate_required([:nome, :observacao])
  end
end
