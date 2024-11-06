defmodule Webapp.Repo.Migrations.CreateRecuperacoesSenha do
  use Ecto.Migration

  def change do
    create table(:recuperacoes_senha) do
      add :token, :string
      add :data_expiracao, :naive_datetime
      add :administrador_id, references(:administradores, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:recuperacoes_senha, [:administrador_id])
  end
end
