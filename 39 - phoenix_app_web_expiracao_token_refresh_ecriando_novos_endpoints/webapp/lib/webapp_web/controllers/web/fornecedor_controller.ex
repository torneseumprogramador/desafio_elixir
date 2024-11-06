defmodule WebappWeb.Controllers.Web.FornecedorController do
  use WebappWeb, :controller

  alias Webapp.Fornecedores
  alias Webapp.Fornecedores.Fornecedor

  def index(conn, _params) do
    fornecedores = Fornecedores.list_fornecedores()
    render(conn, :index, fornecedores: fornecedores)
  end

  def new(conn, _params) do
    changeset = Fornecedores.change_fornecedor(%Fornecedor{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"fornecedor" => fornecedor_params}) do
    case Fornecedores.create_fornecedor(fornecedor_params) do
      {:ok, fornecedor} ->
        conn
        |> put_flash(:info, "Fornecedor created successfully.")
        |> redirect(to: ~p"/fornecedores/#{fornecedor}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    fornecedor = Fornecedores.get_fornecedor!(id)
    render(conn, :show, fornecedor: fornecedor)
  end

  def edit(conn, %{"id" => id}) do
    fornecedor = Fornecedores.get_fornecedor!(id)
    changeset = Fornecedores.change_fornecedor(fornecedor)
    render(conn, :edit, fornecedor: fornecedor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "fornecedor" => fornecedor_params}) do
    fornecedor = Fornecedores.get_fornecedor!(id)

    case Fornecedores.update_fornecedor(fornecedor, fornecedor_params) do
      {:ok, fornecedor} ->
        conn
        |> put_flash(:info, "Fornecedor updated successfully.")
        |> redirect(to: ~p"/fornecedores/#{fornecedor}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, fornecedor: fornecedor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fornecedor = Fornecedores.get_fornecedor!(id)
    {:ok, _fornecedor} = Fornecedores.delete_fornecedor(fornecedor)

    conn
    |> put_flash(:info, "Fornecedor deleted successfully.")
    |> redirect(to: ~p"/fornecedores")
  end
end
