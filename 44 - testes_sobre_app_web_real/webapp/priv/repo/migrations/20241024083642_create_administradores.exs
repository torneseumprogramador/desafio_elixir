defmodule Webapp.Repo.Migrations.CreateAdministradores do
  use Ecto.Migration

  def change do
    create table(:administradores) do
      add :nome, :string, size: 150
      add :email, :string, size: 200

      timestamps(type: :utc_datetime)
    end
  end
end
