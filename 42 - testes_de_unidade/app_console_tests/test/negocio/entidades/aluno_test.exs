defmodule FogetesTest.Negocio.Entidades.AlunoTest do
  use ExUnit.Case
  doctest Fogetes
  alias Negocio.Entidades.Aluno

  test "Propriedades da estrutura" do
    aluno = %Aluno{
      id: 1,
      nome: "danilo",
      matricula: "2",
      notas: [7,8,9]
    }

    assert aluno.id == 1
    assert aluno.nome == "danilo"
    assert aluno.matricula == "2"
    assert aluno.notas == [7,8,9]
  end
end
