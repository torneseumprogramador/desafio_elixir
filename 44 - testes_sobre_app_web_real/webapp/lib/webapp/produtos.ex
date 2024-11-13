defmodule Webapp.Produtos do
  @moduledoc """
  The Produtos context.
  """

  import Ecto.Query, warn: false
  alias Webapp.Repo

  alias Webapp.Produtos.Produto

  @doc """
  Returns the list of produtos.

  ## Examples

      iex> list_produtos()
      [%Produto{}, ...]

  """
  def list_produtos do
    Repo.all(Produto)
  end


  def list_produtos_paginado(query, quantidade_por_pagina \\ 2, pagina \\ 1) do
    pattern = "%#{query}%"

    # Calcula o offset com base na página atual e quantidade por página
    offset = (pagina - 1) * quantidade_por_pagina

    # Obter o total de registros que correspondem ao filtro
    total_registros =
      Repo.one(
        from a in Produto,
        where: ilike(a.nome, ^pattern) or ilike(a.descricao, ^pattern),
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
        from a in Produto,
        where: ilike(a.nome, ^pattern) or ilike(a.descricao, ^pattern),
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

  @doc """
  Gets a single produto.

  Raises `Ecto.NoResultsError` if the Produto does not exist.

  ## Examples

      iex> get_produto!(123)
      %Produto{}

      iex> get_produto!(456)
      ** (Ecto.NoResultsError)

  """
  def get_produto!(id), do: Repo.get!(Produto, id)

  @doc """
  Creates a produto.

  ## Examples

      iex> create_produto(%{field: value})
      {:ok, %Produto{}}

      iex> create_produto(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_produto(attrs \\ %{}) do
    %Produto{}
    |> Produto.changeset(attrs)
    |> Repo.insert()
  end


  def delete_produto_by_id(id) do
    produto = Repo.get(Produto, id)

    case produto do
      nil ->
        {:error, :not_found}
      _ ->
        delete_produto(produto)
    end
  end

  @doc """
  Updates a produto.

  ## Examples

      iex> update_produto(produto, %{field: new_value})
      {:ok, %Produto{}}

      iex> update_produto(produto, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_produto(%Produto{} = produto, attrs) do
    produto
    |> Produto.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a produto.

  ## Examples

      iex> delete_produto(produto)
      {:ok, %Produto{}}

      iex> delete_produto(produto)
      {:error, %Ecto.Changeset{}}

  """
  def delete_produto(%Produto{} = produto) do
    Repo.delete(produto)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking produto changes.

  ## Examples

      iex> change_produto(produto)
      %Ecto.Changeset{data: %Produto{}}

  """
  def change_produto(%Produto{} = produto, attrs \\ %{}) do
    Produto.changeset(produto, attrs)
  end
end
