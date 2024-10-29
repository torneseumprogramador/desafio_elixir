defmodule Scaffold.Repo.Migrations.CreateProdutos do
  use Ecto.Migration

  def change do
    create table(:produtos) do
      add :nome, :string
      add :descricao, :text
      add :quantidade, :integer
      add :preco, :float
      add :data_validade, :date

      timestamps(type: :utc_datetime)
    end
  end
end
