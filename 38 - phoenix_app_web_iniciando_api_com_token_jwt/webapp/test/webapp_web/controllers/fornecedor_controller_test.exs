defmodule WebappWeb.FornecedorControllerTest do
  use WebappWeb.ConnCase

  import Webapp.FornecedoresFixtures

  @create_attrs %{nome: "some nome", observacao: "some observacao"}
  @update_attrs %{nome: "some updated nome", observacao: "some updated observacao"}
  @invalid_attrs %{nome: nil, observacao: nil}

  describe "index" do
    test "lists all fornecedores", %{conn: conn} do
      conn = get(conn, ~p"/fornecedores")
      assert html_response(conn, 200) =~ "Listing Fornecedores"
    end
  end

  describe "new fornecedor" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/fornecedores/new")
      assert html_response(conn, 200) =~ "New Fornecedor"
    end
  end

  describe "create fornecedor" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/fornecedores", fornecedor: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/fornecedores/#{id}"

      conn = get(conn, ~p"/fornecedores/#{id}")
      assert html_response(conn, 200) =~ "Fornecedor #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/fornecedores", fornecedor: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Fornecedor"
    end
  end

  describe "edit fornecedor" do
    setup [:create_fornecedor]

    test "renders form for editing chosen fornecedor", %{conn: conn, fornecedor: fornecedor} do
      conn = get(conn, ~p"/fornecedores/#{fornecedor}/edit")
      assert html_response(conn, 200) =~ "Edit Fornecedor"
    end
  end

  describe "update fornecedor" do
    setup [:create_fornecedor]

    test "redirects when data is valid", %{conn: conn, fornecedor: fornecedor} do
      conn = put(conn, ~p"/fornecedores/#{fornecedor}", fornecedor: @update_attrs)
      assert redirected_to(conn) == ~p"/fornecedores/#{fornecedor}"

      conn = get(conn, ~p"/fornecedores/#{fornecedor}")
      assert html_response(conn, 200) =~ "some updated nome"
    end

    test "renders errors when data is invalid", %{conn: conn, fornecedor: fornecedor} do
      conn = put(conn, ~p"/fornecedores/#{fornecedor}", fornecedor: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Fornecedor"
    end
  end

  describe "delete fornecedor" do
    setup [:create_fornecedor]

    test "deletes chosen fornecedor", %{conn: conn, fornecedor: fornecedor} do
      conn = delete(conn, ~p"/fornecedores/#{fornecedor}")
      assert redirected_to(conn) == ~p"/fornecedores"

      assert_error_sent 404, fn ->
        get(conn, ~p"/fornecedores/#{fornecedor}")
      end
    end
  end

  defp create_fornecedor(_) do
    fornecedor = fornecedor_fixture()
    %{fornecedor: fornecedor}
  end
end
