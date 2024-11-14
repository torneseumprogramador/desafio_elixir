defmodule Webapp.Fornecedores.FornecedorTest do
  use Webapp.DataCase, async: true

  alias Webapp.Fornecedores.Fornecedor

  describe "changeset/2" do
    test "valida sucesso com todos os atributos válidos" do
      attrs = %{nome: "Fornecedor Exemplo", observacao: "Observação sobre o fornecedor"}
      changeset = Fornecedor.changeset(%Fornecedor{}, attrs)

      assert changeset.valid?
    end

    test "valida erro quando o nome está ausente" do
      attrs = %{observacao: "Observação sobre o fornecedor"}
      changeset = Fornecedor.changeset(%Fornecedor{}, attrs)

      refute changeset.valid?
      assert %{nome: ["não pode estar em branco"]} = errors_on(changeset)
    end

    test "valida erro quando a observacao está ausente" do
      attrs = %{nome: "Fornecedor Exemplo"}
      changeset = Fornecedor.changeset(%Fornecedor{}, attrs)

      refute changeset.valid?
      assert %{observacao: ["não pode estar em branco"]} = errors_on(changeset)
    end

    test "valida erro quando ambos os campos estão ausentes" do
      changeset = Fornecedor.changeset(%Fornecedor{}, %{})

      refute changeset.valid?
      assert %{nome: ["não pode estar em branco"], observacao: ["não pode estar em branco"]} = errors_on(changeset)
    end
  end
end
