defmodule Webapp.DashFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Webapp.Dash` context.
  """

  @doc """
  Generate a dashs.
  """
  def dashs_fixture(attrs \\ %{}) do
    {:ok, dashs} =
      attrs
      |> Enum.into(%{

      })
      |> Webapp.Dash.create_dashs()

    dashs
  end
end
