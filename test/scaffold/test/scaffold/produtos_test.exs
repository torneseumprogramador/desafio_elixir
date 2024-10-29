defmodule Scaffold.ProdutosTest do
  use Scaffold.DataCase

  alias Scaffold.Produtos

  describe "produtos" do
    alias Scaffold.Produtos.Produto

    import Scaffold.ProdutosFixtures

    @invalid_attrs %{nome: nil, descricao: nil, quantidade: nil, preco: nil, data_validade: nil}

    test "list_produtos/0 returns all produtos" do
      produto = produto_fixture()
      assert Produtos.list_produtos() == [produto]
    end

    test "get_produto!/1 returns the produto with given id" do
      produto = produto_fixture()
      assert Produtos.get_produto!(produto.id) == produto
    end

    test "create_produto/1 with valid data creates a produto" do
      valid_attrs = %{nome: "some nome", descricao: "some descricao", quantidade: 42, preco: 120.5, data_validade: ~D[2024-10-28]}

      assert {:ok, %Produto{} = produto} = Produtos.create_produto(valid_attrs)
      assert produto.nome == "some nome"
      assert produto.descricao == "some descricao"
      assert produto.quantidade == 42
      assert produto.preco == 120.5
      assert produto.data_validade == ~D[2024-10-28]
    end

    test "create_produto/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Produtos.create_produto(@invalid_attrs)
    end

    test "update_produto/2 with valid data updates the produto" do
      produto = produto_fixture()
      update_attrs = %{nome: "some updated nome", descricao: "some updated descricao", quantidade: 43, preco: 456.7, data_validade: ~D[2024-10-29]}

      assert {:ok, %Produto{} = produto} = Produtos.update_produto(produto, update_attrs)
      assert produto.nome == "some updated nome"
      assert produto.descricao == "some updated descricao"
      assert produto.quantidade == 43
      assert produto.preco == 456.7
      assert produto.data_validade == ~D[2024-10-29]
    end

    test "update_produto/2 with invalid data returns error changeset" do
      produto = produto_fixture()
      assert {:error, %Ecto.Changeset{}} = Produtos.update_produto(produto, @invalid_attrs)
      assert produto == Produtos.get_produto!(produto.id)
    end

    test "delete_produto/1 deletes the produto" do
      produto = produto_fixture()
      assert {:ok, %Produto{}} = Produtos.delete_produto(produto)
      assert_raise Ecto.NoResultsError, fn -> Produtos.get_produto!(produto.id) end
    end

    test "change_produto/1 returns a produto changeset" do
      produto = produto_fixture()
      assert %Ecto.Changeset{} = Produtos.change_produto(produto)
    end
  end
end
