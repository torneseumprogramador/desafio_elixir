defmodule Webapp.FornecedoresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Webapp.Fornecedores` context.
  """

  @doc """
  Generate a fornecedor.
  """
  def fornecedor_fixture(attrs \\ %{}) do
    {:ok, fornecedor} =
      attrs
      |> Enum.into(%{
        nome: "some nome",
        observacao: "some observacao"
      })
      |> Webapp.Fornecedores.create_fornecedor()

    fornecedor
  end
end
