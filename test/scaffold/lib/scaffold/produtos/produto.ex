defmodule Scaffold.Produtos.Produto do
  use Ecto.Schema
  import Ecto.Changeset

  schema "produtos" do
    field :nome, :string
    field :descricao, :string
    field :quantidade, :integer
    field :preco, :float
    field :data_validade, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(produto, attrs) do
    produto
    |> cast(attrs, [:nome, :descricao, :quantidade, :preco, :data_validade])
    |> validate_required([:nome, :descricao, :quantidade, :preco, :data_validade])
  end
end
