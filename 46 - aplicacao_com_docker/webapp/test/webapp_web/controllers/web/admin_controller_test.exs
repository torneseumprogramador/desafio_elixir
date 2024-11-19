defmodule WebappWeb.Controllers.Web.AdminControllerTest do
  use WebappWeb.ConnCase, async: true

  alias Webapp.Administradores
  import Webapp.AdministradoresFixtures

  # ==== Teste de integração e comportamento do web app =====

  setup %{conn: conn} do
    # Cria um administrador de exemplo
    admin = administrador_fixture(%{nome: "Admin1", email: "admin1@example.com"})

    # Cria um token JWT válido com as informações do administrador
    adm_info = %{"id" => admin.id, "nome" => admin.nome, "email" => admin.email}

    {:ok, token, _claims} = Webapp.JWTConfig.generate_and_sign(adm_info, Webapp.JWTConfig.signer())

    # Define o cookie `adm_info` com o token JWT
    conn = put_req_cookie(conn, "adm_info", token)

    # Retorna a conexão autenticada para todos os testes
    {:ok, conn: conn}
  end

  describe "index/2" do
    test "lista administradores e renderiza a página", %{conn: conn} do
      # Faz a requisição para o endpoint protegido
      conn = get(conn, "/administradores")

      # Verifica se a resposta HTML contém a lista de administradores
      assert html_response(conn, 200) =~ "Lista de administradores"
    end
  end

  describe "index/2 com dados mockados" do
    test "lista administradores e renderiza a página", %{conn: conn} do
      # Limpa a tabela de administradores
      Webapp.Repo.delete_all(Webapp.Administradores.Administrador)

      # Adiciona apenas os registros necessários
      administrador_fixture(%{nome: "Admin Mockado 1", email: "mock1@example.com"})
      administrador_fixture(%{nome: "Admin Mockado 2", email: "mock2@example.com"})

      # Faz a requisição para o endpoint protegido
      conn = get(conn, "/administradores")

      # Verifica se a resposta HTML contém a lista de administradores
      html = html_response(conn, 200)

      assert html =~ "Admin Mockado 1"
      assert html =~ "Admin Mockado 2"
    end
  end

  describe "new/2" do
    test "renderiza o formulário para novo administrador", %{conn: conn} do
      conn = get(conn, "/administradores/novo")
      assert html_response(conn, 200) =~ "Novo Administrador"
    end
  end

  describe "register_create/2" do
    test "cria administrador e redireciona para dashboard", %{conn: conn} do
      params = %{"nome" => "Admin", "email" => "admin@example.com", "senha" => "123456", "csenha" => "123456"}
      conn = post(conn, "/administradores", params)

      { _ok,  administrador } = Administradores.find_by_email("admin@example.com")
      assert administrador.email == "admin@example.com"
      assert redirected_to(conn) == "/administradores"
    end
  end

  describe "edit/2" do
    test "renderiza o formulário de edição", %{conn: conn} do
      admin = administrador_fixture()
      conn = get(conn, "/administradores/#{admin.id}/editar")
      assert html_response(conn, 200) =~ "Editar Administrador"
    end
  end

  describe "update/2" do
    test "atualiza o administrador e redireciona", %{conn: conn} do
      admin = administrador_fixture()
      params = %{"nome" => "Novo Nome"}
      conn = post(conn, "/administradores/#{admin.id}/alterar", params)
      assert redirected_to(conn) == "/administradores"
      assert Phoenix.Flash.get(conn.assigns.flash, :success) == "Administrador atualizado com sucesso."
    end

    test "renderiza erro ao falhar na atualização", %{conn: conn} do
      admin = administrador_fixture()
      params = %{"nome" => ""}
      conn = post(conn, "/administradores/#{admin.id}/alterar", params)
      assert html_response(conn, 200) =~ "Erro ao atualizar o administrador"
    end
  end

  describe "delete/2" do
    test "delete/2 apaga o administrador e redireciona", %{conn: conn} do
      # Cria um administrador para ser apagado
      admin = administrador_fixture()

      # Executa a ação delete
      conn = post(conn, "/administradores/#{admin.id}/excluir")

      # Verifica se a mensagem flash foi configurada corretamente
      assert Phoenix.Flash.get(conn.assigns.flash, :info) == "Administrador apagado com sucesso!"

      # Verifica se o redirecionamento ocorreu
      assert redirected_to(conn) == "/administradores"
    end
  end
end
