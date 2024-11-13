defmodule Negocio.Servicos.AlunoServico do
  alias Negocio.Entidades.Aluno

  def instancia(map) do
    %Aluno{
      id: map["id"],
      nome: map["nome"],
      matricula: map["matricula"],
      notas: map["notas"]
    }
  end

  def media_formatada(%Aluno{} = aluno) do
    :io_lib.format("~.2f", [media(aluno)]) |> List.to_string()
  end

  def media(%Aluno{} = aluno) do
    media = Enum.reduce(aluno.notas, 0, fn n1, n2 -> n1 + n2 end) / length(aluno.notas)
    media
  end

  def incluir(alunos, %Aluno{} = aluno) do
    id = DateTime.to_unix(DateTime.utc_now())
    validar_aluno!(aluno)
    aluno_alterado = %{aluno | id: id}
    alunos ++ [aluno_alterado]
  end

  defp validar_aluno!(%Aluno{} = aluno) do
    if is_nil(aluno.id), do: raise("Id é obrigatório")
    if not is_present?(aluno.nome), do: raise("Nome é obrigatório")
    if not is_present?(aluno.matricula), do: raise("Matrícula é obrigatório")
    if length(aluno.notas) < 1, do: raise("O aluno precisa ter pelo menos uma nota")
  end

  defp is_present?(value) do
    not is_nil(value) and value != ""
  end


  def alterar_por_matricula(alunos, %Aluno{} = aluno_a_alterar) do
    Enum.map(alunos, fn aluno ->
      if aluno.matricula == aluno_a_alterar.matricula do
        %Aluno{aluno | nome: aluno_a_alterar.nome, notas: aluno_a_alterar.notas}
      else
        aluno
      end
    end)
  end

  def excluir(alunos, aluno) do
    List.delete(alunos, aluno)
  end

  def excluir_por_matricula(alunos, matricula) do
    aluno = buscar(alunos, matricula)
    if aluno != nil do
      List.delete(alunos, aluno)
    end
  end

  def buscar(alunos, matricula) do
    Enum.find(alunos, fn a -> a.matricula == matricula end)
  end
end
