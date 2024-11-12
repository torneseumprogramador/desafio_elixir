defmodule FogetesTest.Servicos.AlunoServicoTest do
  use ExUnit.Case
  doctest Fogetes
  alias Negocio.Entidades.Aluno
  alias Negocio.Servicos.AlunoServico

  test "Media formatada de alunos" do
    # técnica AAA

    # Arrange (Preparação ou organização)
    aluno = %Aluno{
      id: 1,
      nome: "danilo",
      matricula: "2",
      notas: [7,8,9]
    }

    # Act (ação / execução)
    media = AlunoServico.media_formatada(aluno)

    # Assert (Validação)
    assert media == "8.00"
  end

  test "Media de alunos" do
    # técnica AAA

    # Arrange (Preparação ou organização)
    aluno = %Aluno{
      id: 1,
      nome: "danilo",
      matricula: "2",
      notas: [7,8,9]
    }

    # Act (ação / execução)
    media = AlunoServico.media(aluno)

    # Assert (Validação)
    assert media == 8.0
  end

  test "Incluir aluno" do
    # técnica AAA

    # Arrange (Preparação ou organização)
    alunos = []
    aluno = %Aluno{
      id: 1,
      nome: "danilo",
      matricula: "2",
      notas: [7,8,9]
    }

    # Act (ação / execução)
    nova_lista_com_aluno = AlunoServico.incluir(alunos, aluno)

    # Assert (Validação)
    assert length(nova_lista_com_aluno) > 0
  end

  test "Incluir aluno em lista com itens" do
    # técnica AAA

    # Arrange (Preparação ou organização)
    alunos = [
      %Aluno{
        id: 1,
        nome: "danilo",
        matricula: "2",
        notas: [7,8,9]
      },
      %Aluno{
        id: 1,
        nome: "danilo",
        matricula: "2",
        notas: [7,8,9]
      }
    ]

    aluno = %Aluno{
      id: 1,
      nome: "danilo",
      matricula: "2",
      notas: [7,8,9]
    }

    # Act (ação / execução)
    nova_lista_com_aluno = AlunoServico.incluir(alunos, aluno)

    # Assert (Validação)
    assert length(nova_lista_com_aluno) == 3
  end

  test "Alterar aluno em lista" do
    # técnica AAA

    # Arrange (Preparação ou organização)
    alunos = [
      %Aluno{
        id: 1,
        nome: "danilo",
        matricula: "1",
        notas: [7,8,9]
      },
      %Aluno{
        id: 2,
        nome: "lana",
        matricula: "2",
        notas: [8,9]
      }
    ]

    aluno_antigo = Enum.at(alunos, 0)

    aluno_a_alterar = %Aluno{
      id: 1,
      nome: "Danilo",
      matricula: "1", # item principal para alteração
      notas: [7,8,9,10]
    }


    # Act (ação / execução)
    lista_alunos_alterados = AlunoServico.alterar_por_matricula(alunos, aluno_a_alterar)

    # Assert (Validação)
    aluno_alterado = Enum.at(lista_alunos_alterados, 0)

    assert aluno_alterado.nome == "Danilo"
    assert aluno_alterado.notas == [7,8,9,10]

    assert aluno_alterado.nome != aluno_antigo.nome
    assert aluno_alterado.notas != aluno_antigo.notas
  end

  test "Excluir aluno em lista" do
    # técnica AAA

    # Arrange (Preparação ou organização)
    alunos = [
      %Aluno{
        id: 1,
        nome: "danilo",
        matricula: "1",
        notas: [7,8,9]
      },
      %Aluno{
        id: 2,
        nome: "lana",
        matricula: "2",
        notas: [8,9]
      }
    ]

    aluno_a_excluir = Enum.at(alunos, 0)
    quantidade_alunos_antes_exclusao = length(alunos)

    # Act (ação / execução)
    alunos_com_exclusao = AlunoServico.excluir(alunos, aluno_a_excluir)

    # Assert (Validação)
    assert quantidade_alunos_antes_exclusao > length(alunos_com_exclusao)
  end

  test "Excluir aluno por matricula" do
    # técnica AAA

    # Arrange (Preparação ou organização)
    alunos = [
      %Aluno{
        id: 1,
        nome: "danilo",
        matricula: "1",
        notas: [7,8,9]
      },
      %Aluno{
        id: 2,
        nome: "lana",
        matricula: "2",
        notas: [8,9]
      }
    ]

    quantidade_alunos_antes_exclusao = length(alunos)

    # Act (ação / execução)
    alunos_com_exclusao = AlunoServico.excluir_por_matricula(alunos, "2")

    # Assert (Validação)
    assert quantidade_alunos_antes_exclusao > length(alunos_com_exclusao)
  end

  test "Buscar aluno por matricula" do
    # técnica AAA

    # Arrange (Preparação ou organização)
    alunos = [
      %Aluno{
        id: 1,
        nome: "danilo",
        matricula: "1",
        notas: [7,8,9]
      },
      %Aluno{
        id: 2,
        nome: "lana",
        matricula: "2",
        notas: [8,9]
      }
    ]

    # Act (ação / execução)
    aluno_encontrado = AlunoServico.excluir_por_matricula(alunos, "2")

    # Assert (Validação)
    assert !is_nil(aluno_encontrado)
  end


  test "Buscar aluno por matricula não cadastrada" do
    # técnica AAA

    # Arrange (Preparação ou organização)
    alunos = [
      %Aluno{
        id: 1,
        nome: "danilo",
        matricula: "1",
        notas: [7,8,9]
      },
      %Aluno{
        id: 2,
        nome: "lana",
        matricula: "2",
        notas: [8,9]
      }
    ]

    # Act (ação / execução)
    aluno_encontrado = AlunoServico.excluir_por_matricula(alunos, "3")

    # Assert (Validação)
    assert is_nil(aluno_encontrado)
  end
end
