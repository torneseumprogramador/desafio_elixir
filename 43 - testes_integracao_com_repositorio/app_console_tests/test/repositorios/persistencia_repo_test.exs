defmodule FogetesTest.Repositios.PersistenciaRepoTest do
  use ExUnit.Case
  alias Repositorios.PersistenciaRepo
  alias Negocio.Servicos.AlunoServico
  alias Negocio.Entidades.Aluno
  import ExUnit.CaptureIO

  setup do
    # Configura um diretório temporário para os arquivos de teste
    :ok = File.mkdir_p("db_test")
    on_exit(fn -> File.rm_rf("db_test") end)
  end

  test "salvar/2 cria um arquivo JSON com a lista de alunos" do
    # Arrange
    alunos = [
      %Aluno{id: 1, nome: "danilo", matricula: "1", notas: [7, 8, 9]},
      %Aluno{id: 2, nome: "lana", matricula: "2", notas: [8, 9]}
    ]
    nome_arquivo = "alunos.json"

    # Act
    PersistenciaRepo.salvar(alunos, nome_arquivo, "db_test")

    # Assert
    assert File.exists?("db_test/#{nome_arquivo}")
  end

  test "buscar/1 lê e decodifica o arquivo JSON para uma lista de structs Aluno" do
    # Arrange
    nome_arquivo = "alunos.json"
    alunos = [
      %Aluno{id: 1, nome: "danilo", matricula: "1", notas: [7, 8, 9]},
      %Aluno{id: 2, nome: "lana", matricula: "2", notas: [8, 9]}
    ]
    PersistenciaRepo.salvar(alunos, nome_arquivo, "db_test")

    # Act
    resultado = PersistenciaRepo.buscar(nome_arquivo, &AlunoServico.instancia/1, "db_test")

    # Assert
    assert length(resultado) == 2
    assert is_struct(Enum.at(resultado, 0), Aluno)
    assert Enum.at(resultado, 0).nome == "danilo"
    assert Enum.at(resultado, 1).nome == "lana"
  end

  test "buscar/1 retorna nil e exibe erro ao tentar ler um arquivo inexistente" do
    # Arrange
    nome_arquivo = "arquivo_inexistente.json"

    # Act and Assert
    assert capture_io(fn ->
      assert PersistenciaRepo.buscar(nome_arquivo, &AlunoServico.instancia/1, "db_test") == nil
    end) =~ "Erro ao ler o arquivo"
  end

  test "buscar/1 exibe erro ao tentar decodificar um JSON inválido" do
    # Arrange
    nome_arquivo = "alunos.json"
    File.write!("db_test/#{nome_arquivo}", "conteudo_invalido")

    # Act and Assert
    assert capture_io(fn ->
      assert PersistenciaRepo.buscar(nome_arquivo, &AlunoServico.instancia/1, "db_test") == nil
    end) =~ "Erro ao decodificar JSON"
  end
end
