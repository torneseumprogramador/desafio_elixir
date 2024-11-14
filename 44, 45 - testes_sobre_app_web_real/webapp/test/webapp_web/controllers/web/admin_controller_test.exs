defmodule WebappWeb.Controllers.Web.AdminControllerTest do
  use WebappWeb.ConnCase, async: true

  alias Webapp.Administradores
  import Webapp.AdministradoresFixtures

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
end




  # describe "create/2" do
  #   test "cria administrador e redireciona para a lista de administradores", %{conn: conn} do
  #     params = %{"nome" => "Admin", "email" => "admin@example.com", "senha" => "123456"}
  #     conn = post(conn, "/administradores", params)
  #     assert redirected_to(conn) == "/administradores"
  #     assert get_flash(conn, :info) == "Administrador criado com sucesso!"
  #   end
  # end

  # describe "edit/2" do
  #   test "renderiza o formulário de edição", %{conn: conn} do
  #     admin = administrador_fixture()
  #     conn = get(conn, "/administradores/#{admin.id}/edit")
  #     assert html_response(conn, 200) =~ "Editar Administrador"
  #   end
  # end

  # describe "update/2" do
  #   test "atualiza o administrador e redireciona", %{conn: conn} do
  #     admin = administrador_fixture()
  #     params = %{"nome" => "Novo Nome"}
  #     conn = put(conn, "/administradores/#{admin.id}", params)
  #     assert redirected_to(conn) == "/administradores"
  #     assert get_flash(conn, :success) == "Administrador atualizado com sucesso."
  #   end

  #   test "renderiza erro ao falhar na atualização", %{conn: conn} do
  #     admin = administrador_fixture()
  #     params = %{"nome" => ""}
  #     conn = put(conn, "/administradores/#{admin.id}", params)
  #     assert html_response(conn, 200) =~ "Erro ao atualizar o administrador"
  #   end
  # end

  # describe "delete/2" do
  #   test "apaga o administrador e redireciona", %{conn: conn} do
  #     admin = administrador_fixture()
  #     conn = delete(conn, "/administradores/#{admin.id}")
  #     assert redirected_to(conn) == "/administradores"
  #     assert get_flash(conn, :info) == "Administrador criado com sucesso!"
  #   end
  # end
# end
