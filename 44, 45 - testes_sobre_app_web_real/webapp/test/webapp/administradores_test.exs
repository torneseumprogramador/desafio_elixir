defmodule Webapp.AdministradoresTest do
  use Webapp.DataCase, async: true
  import Webapp.AdministradoresFixtures

  alias Webapp.Administradores
  alias Webapp.Administradores.Administrador

  describe "list_administradores/0" do
    test "retorna a lista de administradores" do
      # Arrange
      admin = administrador_fixture(nome: "Admin1", email: "admin1@example.com")
      # Act & Assert
      assert Administradores.list_administradores() == [admin]
    end
  end

  describe "find_by_email/1" do
    test "retorna o administrador quando o email existe" do
      admin = administrador_fixture(email: "test@example.com")
      assert {:ok, ^admin} = Administradores.find_by_email("test@example.com")
    end

    test "retorna erro quando o email não existe" do
      assert {:error, :not_found} = Administradores.find_by_email("nonexistent@example.com")
    end
  end

  describe "list_administradores_by_nome_or_email_paginado/3" do
    test "retorna lista paginada de administradores que correspondem ao filtro" do
      administrador_fixture(nome: "Admin1", email: "admin1@example.com")
      administrador_fixture(nome: "Admin2", email: "admin2@example.com")
      result = Administradores.list_administradores_by_nome_or_email_paginado("Admin", 2, 1)

      assert result.pagina_corrente == 1
      assert result.quantidade_de_registros == 2
      assert result.quantidade_de_paginas == 1
    end
  end

  describe "create_administrador/1" do
    test "cria um administrador com atributos válidos" do
      attrs = %{nome: "Novo Admin", email: "novo@example.com", senha: "123456"}
      assert {:ok, %Administrador{} = admin} = Administradores.create_administrador(attrs)
      assert admin.nome == "Novo Admin"
    end

    test "retorna erro com atributos inválidos" do
      attrs = %{nome: "", email: ""}
      assert {:error, changeset} = Administradores.create_administrador(attrs)
      refute changeset.valid?
    end
  end

  describe "update_administrador/2" do
    test "atualiza um administrador existente" do
      admin = administrador_fixture(nome: "Admin Original")
      assert {:ok, %Administrador{} = updated_admin} = Administradores.update_administrador(admin, %{nome: "Admin Atualizado"})
      assert updated_admin.nome == "Admin Atualizado"
    end
  end

  describe "delete_administrador/1" do
    test "deleta um administrador existente" do
      admin = administrador_fixture()
      assert {:ok, %Administrador{}} = Administradores.delete_administrador(admin)
      assert [] = Administradores.list_administradores()
    end
  end

  describe "delete_administrador_by_id/1" do
    test "deleta um administrador por ID" do
      admin = administrador_fixture()
      assert {:ok, %Administrador{}} = Administradores.delete_administrador_by_id(admin.id)
    end

    test "retorna erro se o ID não existe" do
      assert {:error, :not_found} = Administradores.delete_administrador_by_id(-1)
    end
  end

  describe "get_administrador!/1" do
    test "retorna o administrador pelo ID" do
      admin = administrador_fixture()
      assert Administradores.get_administrador!(admin.id) == admin
    end
  end
end
