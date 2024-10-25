defmodule Webapp.Administrador do
  use Ecto.Schema
  import Ecto.Changeset

  schema "administradores" do
    field :nome, :string
    field :email, :string
    field :senha, :string, virtual: true
    field :senha_hash, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(administrador, attrs) do
    administrador
    |> cast(attrs, [:nome, :email, :senha])
    |> validate_required([:nome, :email])
    |> validate_length(:senha, min: 6)
    |> put_senha_hash()
  end

  defp put_senha_hash(changeset) do
    case get_change(changeset, :senha) do
      nil -> changeset
      senha -> put_change(changeset, :senha_hash, Bcrypt.hash_pwd_salt(senha))
    end
  end
end
