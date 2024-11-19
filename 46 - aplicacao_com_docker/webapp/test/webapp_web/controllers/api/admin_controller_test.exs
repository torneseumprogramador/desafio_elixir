defmodule WebappWeb.Controllers.Api.AdminControllerTest do
  use WebappWeb.ConnCase, async: true

  alias Webapp.Administradores
  import Webapp.AdministradoresFixtures

  # ==== Teste de integração e comportamento da api =====


  setup %{conn: conn} do
    # Cria um administrador de exemplo
    admin = administrador_fixture(%{nome: "Admin1", email: "admin1@example.com"})

    # Cria um token JWT válido com as informações do administrador
    adm_info = %{
      "id" => admin.id,
      "nome" => admin.nome,
      "email" => admin.email,
      "data_expiracao" => DateTime.utc_now() |> DateTime.add(3600, :second) |> DateTime.to_iso8601()
    }

    {:ok, token, _claims} = Webapp.JWTConfig.generate_and_sign(adm_info, Webapp.JWTConfig.signer())

    # Retorna a conexão autenticada com o token no cabeçalho
    conn =
      conn
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn}
  end

  describe "index/2" do
    test "lista administradores e retorna JSON paginado", %{conn: conn} do
      # Cria dados mockados no banco
      administrador_fixture(%{nome: "Admin2", email: "admin2@example.com"})

      # Faz a requisição para o endpoint protegido
      conn = get(conn, "/api/administradores")

      # Captura a resposta JSON
      json = json_response(conn, 200)

      # Verifica se o JSON retornado contém os administradores
      assert json["pagina_corrente"] == 1
      assert json["quantidade_de_registros"] == 2
      assert Enum.any?(json["registros"], fn admin -> admin["nome"] == "Admin1" end)
      assert Enum.any?(json["registros"], fn admin -> admin["nome"] == "Admin2" end)
    end
  end

  describe "get/2" do
    test "retorna um administrador pelo ID", %{conn: conn} do
      admin = administrador_fixture(%{nome: "Admin3", email: "admin3@example.com"})

      # Faz a requisição para o endpoint de detalhe
      conn = get(conn, "/api/administradores/#{admin.id}")

      # Verifica se a resposta contém o administrador correto
      json = json_response(conn, 200)
      assert json["nome"] == "Admin3"
      assert json["email"] == "admin3@example.com"
    end

    test "retorna erro 404 para administrador não encontrado", %{conn: conn} do
      # Faz a requisição para um ID inexistente
      conn = get(conn, "/api/administradores/999999")

      # Verifica se a resposta retorna 404
      json = json_response(conn, 404)
      assert json["error"] == "Administrador não encontrado"
    end
  end

  describe "POST /api/administradores" do
    test "cria um administrador com sucesso", %{conn: conn} do
      params = %{"nome" => "Admin Novo", "email" => "adminnovo@example.com", "senha" => "123456"}

      conn = post(conn, "/api/administradores", params)

      json = json_response(conn, 201)
      assert json["nome"] == "Admin Novo"
      assert json["email"] == "adminnovo@example.com"
    end

    test "retorna erro para parâmetros inválidos", %{conn: conn} do
      params = %{"nome" => "", "email" => "adminnovo@example.com", "senha" => "123456"}

      conn = post(conn, "/api/administradores", params)

      json = json_response(conn, 400)

      assert json["errors"]["nome"] != nil
    end
  end

  describe "PUT /api/administradores/:id" do
    test "atualiza um administrador com sucesso", %{conn: conn} do
      admin = administrador_fixture()

      params = %{"nome" => "Admin Atualizado"}
      conn = put(conn, "/api/administradores/#{admin.id}", params)

      json = json_response(conn, 200)
      assert json["nome"] == "Admin Atualizado"
    end

    test "retorna erro para administrador inexistente", %{conn: conn} do
      params = %{"nome" => "Admin Inexistente"}
      conn = put(conn, "/api/administradores/999999", params)

      json = json_response(conn, 404)
      assert json["error"] == "Administrador não encontrado"
    end
  end

  describe "DELETE /api/administradores/:id" do
    test "apaga um administrador com sucesso", %{conn: conn} do
      admin = administrador_fixture()

      conn = delete(conn, "/api/administradores/#{admin.id}")

      assert response(conn, 204)
      assert Administradores.find_by_email(admin.email) == {:error, :not_found}
    end

    test "retorna erro para administrador inexistente", %{conn: conn} do
      conn = delete(conn, "/api/administradores/999999")

      json = json_response(conn, 404)
      assert json["error"] == "Administrador não encontrado"
    end
  end
end
