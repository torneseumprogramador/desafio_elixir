defmodule Webapp.ProdutosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Webapp.Produtos` context.
  """

  @doc """
  Generate a produto.
  """
  def produto_fixture(attrs \\ %{}) do
    {:ok, produto} =
      attrs
      |> Enum.into(%{
        data_validade: ~D[2024-10-28],
        descricao: "some descricao",
        nome: "some nome",
        preco: 120.5,
        quantidade: 42
      })
      |> Webapp.Produtos.create_produto()

    produto
  end
end
