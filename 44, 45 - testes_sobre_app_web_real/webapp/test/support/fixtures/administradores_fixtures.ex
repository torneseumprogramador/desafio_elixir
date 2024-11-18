defmodule Webapp.AdministradoresFixtures do
  alias Webapp.Administradores.Administrador
  alias Webapp.Repo

  # ==== Serve para alimentar banco de dados =====

  @doc """
  Cria um administrador com os atributos fornecidos ou valores padrão.
  """
  def administrador_fixture(attrs \\ %{}) do
    attrs = Enum.into(attrs, %{}) # Converte lista de pares chave-valor em mapa, se necessário

    default_attrs = %{
      nome: "Admin Default",
      email: "admin_default@example.com",
      senha: "123456"
    }

    merged_attrs = Map.merge(default_attrs, attrs, fn _key, default, value ->
      if value == nil, do: default, else: value
    end)

    {:ok, admin} =
      %Administrador{}
      |> Administrador.changeset(merged_attrs)
      |> Repo.insert()

    %{admin | senha: nil}
  end
end
