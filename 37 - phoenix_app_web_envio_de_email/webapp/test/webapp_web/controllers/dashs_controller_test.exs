defmodule WebappWeb.DashsControllerTest do
  use WebappWeb.ConnCase

  import Webapp.DashFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all dashs", %{conn: conn} do
      conn = get(conn, ~p"/dashs")
      assert html_response(conn, 200) =~ "Listing Dashs"
    end
  end

  describe "new dashs" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/dashs/new")
      assert html_response(conn, 200) =~ "New Dashs"
    end
  end

  describe "create dashs" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/dashs", dashs: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/dashs/#{id}"

      conn = get(conn, ~p"/dashs/#{id}")
      assert html_response(conn, 200) =~ "Dashs #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/dashs", dashs: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Dashs"
    end
  end

  describe "edit dashs" do
    setup [:create_dashs]

    test "renders form for editing chosen dashs", %{conn: conn, dashs: dashs} do
      conn = get(conn, ~p"/dashs/#{dashs}/edit")
      assert html_response(conn, 200) =~ "Edit Dashs"
    end
  end

  describe "update dashs" do
    setup [:create_dashs]

    test "redirects when data is valid", %{conn: conn, dashs: dashs} do
      conn = put(conn, ~p"/dashs/#{dashs}", dashs: @update_attrs)
      assert redirected_to(conn) == ~p"/dashs/#{dashs}"

      conn = get(conn, ~p"/dashs/#{dashs}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, dashs: dashs} do
      conn = put(conn, ~p"/dashs/#{dashs}", dashs: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Dashs"
    end
  end

  describe "delete dashs" do
    setup [:create_dashs]

    test "deletes chosen dashs", %{conn: conn, dashs: dashs} do
      conn = delete(conn, ~p"/dashs/#{dashs}")
      assert redirected_to(conn) == ~p"/dashs"

      assert_error_sent 404, fn ->
        get(conn, ~p"/dashs/#{dashs}")
      end
    end
  end

  defp create_dashs(_) do
    dashs = dashs_fixture()
    %{dashs: dashs}
  end
end
