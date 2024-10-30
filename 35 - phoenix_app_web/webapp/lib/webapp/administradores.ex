# AdministradorContext == AdministradorService numa arquitetura Service Layer
# devemos chamar de context
defmodule Webapp.Administradores do
  alias Webapp.Repo
  alias Webapp.Administradores.Administrador
  import Ecto.Query, only: [from: 2]

  @doc """
  Retorna a lista de administradores.
  """
  def list_administradores do
    Repo.all(Administrador)
  end

  def list_administradores_by_nome_or_email(query) do
    pattern = "%#{query}%"

    Repo.all(
      from a in Administrador,
      where: ilike(a.nome, ^pattern) or ilike(a.email, ^pattern)
    )
  end

  @doc """
  Cria um administrador com os atributos fornecidos.
  """
  def create_administrador(attrs \\ %{}) do
    %Administrador{}
    |> Administrador.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Atualiza um administrador existente.
  """
  def update_administrador(%Administrador{} = administrador, attrs) do
    administrador
    |> Administrador.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deleta um administrador.
  """
  def delete_administrador(%Administrador{} = administrador) do
    Repo.delete(administrador)
  end

  @doc """
  Deleta um administrador por ID.
  """
  def delete_administrador_by_id(id) do
    administrador = Repo.get(Administrador, id)

    case administrador do
      nil ->
        {:error, :not_found}
      _ ->
        delete_administrador(administrador)
    end
  end

  @doc """
  Retorna um administrador pelo ID.
  """
  def get_administrador!(id) do
    Repo.get!(Administrador, id)
  end
end
