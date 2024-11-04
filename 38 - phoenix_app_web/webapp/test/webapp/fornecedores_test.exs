defmodule Webapp.FornecedoresTest do
  use Webapp.DataCase

  alias Webapp.Fornecedores

  describe "fornecedores" do
    alias Webapp.Fornecedores.Fornecedor

    import Webapp.FornecedoresFixtures

    @invalid_attrs %{nome: nil, observacao: nil}

    test "list_fornecedores/0 returns all fornecedores" do
      fornecedor = fornecedor_fixture()
      assert Fornecedores.list_fornecedores() == [fornecedor]
    end

    test "get_fornecedor!/1 returns the fornecedor with given id" do
      fornecedor = fornecedor_fixture()
      assert Fornecedores.get_fornecedor!(fornecedor.id) == fornecedor
    end

    test "create_fornecedor/1 with valid data creates a fornecedor" do
      valid_attrs = %{nome: "some nome", observacao: "some observacao"}

      assert {:ok, %Fornecedor{} = fornecedor} = Fornecedores.create_fornecedor(valid_attrs)
      assert fornecedor.nome == "some nome"
      assert fornecedor.observacao == "some observacao"
    end

    test "create_fornecedor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fornecedores.create_fornecedor(@invalid_attrs)
    end

    test "update_fornecedor/2 with valid data updates the fornecedor" do
      fornecedor = fornecedor_fixture()
      update_attrs = %{nome: "some updated nome", observacao: "some updated observacao"}

      assert {:ok, %Fornecedor{} = fornecedor} = Fornecedores.update_fornecedor(fornecedor, update_attrs)
      assert fornecedor.nome == "some updated nome"
      assert fornecedor.observacao == "some updated observacao"
    end

    test "update_fornecedor/2 with invalid data returns error changeset" do
      fornecedor = fornecedor_fixture()
      assert {:error, %Ecto.Changeset{}} = Fornecedores.update_fornecedor(fornecedor, @invalid_attrs)
      assert fornecedor == Fornecedores.get_fornecedor!(fornecedor.id)
    end

    test "delete_fornecedor/1 deletes the fornecedor" do
      fornecedor = fornecedor_fixture()
      assert {:ok, %Fornecedor{}} = Fornecedores.delete_fornecedor(fornecedor)
      assert_raise Ecto.NoResultsError, fn -> Fornecedores.get_fornecedor!(fornecedor.id) end
    end

    test "change_fornecedor/1 returns a fornecedor changeset" do
      fornecedor = fornecedor_fixture()
      assert %Ecto.Changeset{} = Fornecedores.change_fornecedor(fornecedor)
    end
  end
end
