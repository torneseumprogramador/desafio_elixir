defmodule Webapp.DashTest do
  use Webapp.DataCase

  alias Webapp.Dash

  describe "dashs" do
    alias Webapp.Dash.Dashs

    import Webapp.DashFixtures

    @invalid_attrs %{}

    test "list_dashs/0 returns all dashs" do
      dashs = dashs_fixture()
      assert Dash.list_dashs() == [dashs]
    end

    test "get_dashs!/1 returns the dashs with given id" do
      dashs = dashs_fixture()
      assert Dash.get_dashs!(dashs.id) == dashs
    end

    test "create_dashs/1 with valid data creates a dashs" do
      valid_attrs = %{}

      assert {:ok, %Dashs{} = dashs} = Dash.create_dashs(valid_attrs)
    end

    test "create_dashs/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dash.create_dashs(@invalid_attrs)
    end

    test "update_dashs/2 with valid data updates the dashs" do
      dashs = dashs_fixture()
      update_attrs = %{}

      assert {:ok, %Dashs{} = dashs} = Dash.update_dashs(dashs, update_attrs)
    end

    test "update_dashs/2 with invalid data returns error changeset" do
      dashs = dashs_fixture()
      assert {:error, %Ecto.Changeset{}} = Dash.update_dashs(dashs, @invalid_attrs)
      assert dashs == Dash.get_dashs!(dashs.id)
    end

    test "delete_dashs/1 deletes the dashs" do
      dashs = dashs_fixture()
      assert {:ok, %Dashs{}} = Dash.delete_dashs(dashs)
      assert_raise Ecto.NoResultsError, fn -> Dash.get_dashs!(dashs.id) end
    end

    test "change_dashs/1 returns a dashs changeset" do
      dashs = dashs_fixture()
      assert %Ecto.Changeset{} = Dash.change_dashs(dashs)
    end
  end
end
