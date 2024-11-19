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

  def find_by_email(email) do
    case Repo.get_by(Administrador, email: email) do
      nil -> {:error, :not_found}
      admin -> {:ok, admin}
    end
  end

  def list_administradores_by_nome_or_email_paginado(query, quantidade_por_pagina \\ 2, pagina \\ 1) do
    pattern = "%#{query}%"

    # Calcula o offset com base na página atual e quantidade por página
    offset = (pagina - 1) * quantidade_por_pagina

    # Obter o total de registros que correspondem ao filtro
    total_registros =
      Repo.one(
        from a in Administrador,
        where: ilike(a.nome, ^pattern) or ilike(a.email, ^pattern),
        select: count(a.id)
      )

    # Calcular a quantidade de páginas com base no total de registros e quantidade por página
    quantidade_de_paginas =
      if total_registros > 0 do
        Float.ceil(total_registros / quantidade_por_pagina) |> round()
      else
        1
      end

    # Obter os registros da página atual
    registros =
      Repo.all(
        from a in Administrador,
        where: ilike(a.nome, ^pattern) or ilike(a.email, ^pattern),
        limit: ^quantidade_por_pagina,
        offset: ^offset
      )

    # Retornar a estrutura JSON desejada
    %{
      pagina_corrente: pagina,
      quantidade_de_registros: total_registros,
      registros: registros,
      quantidade_de_paginas: quantidade_de_paginas
    }
  end


  def list_administradores_by_nome_or_email(query, limit \\ 2, offset \\ 0) do
    pattern = "%#{query}%"

    Repo.all(
      from a in Administrador,
      where: ilike(a.nome, ^pattern) or ilike(a.email, ^pattern),
      limit: ^limit,
      offset: ^offset
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
