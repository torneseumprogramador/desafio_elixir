defmodule WebappWeb.Controllers.Api.ProdutoController do
  use WebappWeb, :controller

  alias Webapp.Produtos

  def index(conn, params \\ %{}) do
    q = Map.get(params, "q", nil)
    pagina = Map.get(params, "pagina", "1") |> String.to_integer()
    produtos_paginado = Produtos.list_produtos_paginado(q, 5, pagina)
    json(conn, produtos_paginado)
  end

  def get(conn, %{"id" => id}) do
    try do
      produto = Produtos.get_produto!(id)
      json(conn, produto)
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Produto não encontrado"})
    end
  end

  def create(conn, %{"nome" => nome, "descricao" => descricao, "quantidade" => quantidade, "preco" => preco}) do
    attrs = %{"nome" => nome, "descricao" => descricao, "quantidade" => quantidade, "preco" => preco}

    case Produtos.create_produto(attrs) do
      {:ok, produto} ->
        conn
        |> put_status(:created)
        |> json(produto)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(changeset)
    end
  end

  def update(conn, %{"id" => id} = params) do
    try do
      produto = Produtos.get_produto!(id)
      case Produtos.update_produto(produto, params) do
        {:ok, produto} ->
          conn
          |> put_status(:ok)
          |> json(produto)

        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_status(:bad_request)
          |> json(changeset)
      end
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Produto não encontrado"})
    end
  end

  def delete(conn, %{"id" => id}) do
    case Produtos.delete_produto_by_id(id) do
      {:ok, _produto} ->
        conn
        |> put_status(:no_content)
        |> json(%{})

      {:error, _} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Produto não encontrado"})
    end
  end
end
