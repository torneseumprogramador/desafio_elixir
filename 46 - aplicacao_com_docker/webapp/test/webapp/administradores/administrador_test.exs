defmodule Webapp.Administradores.AdministradorTest do
  use Webapp.DataCase, async: true

  # ==== testando schema em um padrão de test de unidade =====

  alias Webapp.Administradores.Administrador

  describe "changeset/2" do
    test "valida sucesso com todos os atributos válidos" do
      attrs = %{nome: "João", email: "joao@example.com", senha: "123456"}
      changeset = Administrador.changeset(%Administrador{}, attrs)

      assert changeset.valid?
    end

    test "valida erro quando o nome está ausente" do
      attrs = %{email: "joao@example.com", senha: "123456"}
      changeset = Administrador.changeset(%Administrador{}, attrs)

      refute changeset.valid?
      assert %{nome: ["não pode estar em branco"]} = errors_on(changeset)
    end

    test "valida erro quando o email está ausente" do
      attrs = %{nome: "João", senha: "123456"}
      changeset = Administrador.changeset(%Administrador{}, attrs)

      refute changeset.valid?
      assert %{email: ["não pode estar em branco"]} = errors_on(changeset)
    end

    test "valida erro quando a senha é muito curta" do
      attrs = %{nome: "João", email: "joao@example.com", senha: "123"}
      changeset = Administrador.changeset(%Administrador{}, attrs)

      refute changeset.valid?
      assert %{senha: ["deve ter pelo menos 6 caracteres"]} = errors_on(changeset)
    end

    test "valida que o hash da senha é gerado" do
      attrs = %{nome: "João", email: "joao@example.com", senha: "123456"}
      changeset = Administrador.changeset(%Administrador{}, attrs)

      assert changeset.valid?
      assert changeset.changes.senha_hash
      assert Bcrypt.verify_pass("123456", changeset.changes.senha_hash)
    end
  end
end
