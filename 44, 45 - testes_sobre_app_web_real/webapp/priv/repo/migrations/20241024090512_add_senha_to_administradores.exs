defmodule Webapp.Repo.Migrations.AddSenhaToAdministradores do
  use Ecto.Migration

  def change do
    alter table(:administradores) do
      add :senha_hash, :string
    end
  end
end
