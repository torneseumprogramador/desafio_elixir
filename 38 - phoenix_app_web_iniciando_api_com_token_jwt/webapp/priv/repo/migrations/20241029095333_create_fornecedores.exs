defmodule Webapp.Repo.Migrations.CreateFornecedores do
  use Ecto.Migration

  def change do
    create table(:fornecedores) do
      add :nome, :string
      add :observacao, :text

      timestamps(type: :utc_datetime)
    end
  end
end
