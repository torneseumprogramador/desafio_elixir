defmodule WebappWeb.ProdutoController do
  use WebappWeb, :controller

  alias Webapp.Produtos
  alias Webapp.Produtos.Produto

  def index(conn, _params) do
    produtos = Produtos.list_produtos()
    render(conn, :index, produtos: produtos)
  end

  def new(conn, _params) do
    changeset = Produtos.change_produto(%Produto{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"produto" => produto_params}) do
    case Produtos.create_produto(produto_params) do
      {:ok, produto} ->
        conn
        |> put_flash(:info, "Produto created successfully.")
        |> redirect(to: ~p"/produtos/#{produto}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    produto = Produtos.get_produto!(id)
    render(conn, :show, produto: produto)
  end

  def edit(conn, %{"id" => id}) do
    produto = Produtos.get_produto!(id)
    changeset = Produtos.change_produto(produto)
    render(conn, :edit, produto: produto, changeset: changeset)
  end

  def update(conn, %{"id" => id, "produto" => produto_params}) do
    produto = Produtos.get_produto!(id)

    case Produtos.update_produto(produto, produto_params) do
      {:ok, produto} ->
        conn
        |> put_flash(:info, "Produto updated successfully.")
        |> redirect(to: ~p"/produtos/#{produto}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, produto: produto, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    produto = Produtos.get_produto!(id)
    {:ok, _produto} = Produtos.delete_produto(produto)

    conn
    |> put_flash(:info, "Produto deleted successfully.")
    |> redirect(to: ~p"/produtos")
  end
end
