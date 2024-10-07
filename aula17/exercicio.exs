# Sergião dos foguetes é um cientista que precisa avaliar sua turma
# para isso ele precisa de um sistema que armazene:
# - id (automatico)
# - nome
# - matricula
# - notas (lista, pode colocar quantas quiser)

# Este sistema precisa ter um menu onde:
# 1 - Cadastrar aluno
# 2 - Listar alunos
# 3 - Alterar aluno
# 4 - Procurar aluno
# 5 - Excluir aluno
# 0 - Sair do programa

# Na lista de alunos, sempre mostrar suas notas e a média aritimética
# ID: 12343213
# Nome: Elena
# Matricula: MSE143
# Notas: [3, 5, 9]
# Média: (3+5+9)/ 3 = 5,66

defmodule Aluno do
  defstruct id: 0, nome: "", matricula: "", notas: []
end

defmodule AlunoServico do
  def media(%Aluno{} = aluno) do
    media = Enum.reduce(aluno.notas, 0, fn n1, n2 -> n1 + n2 end) / length(aluno.notas)
    :io_lib.format("~.2f", [media]) |> List.to_string()
  end
end

defmodule ProgramaDoSergio do
  def init() do
    Menu.init()
  end
end

defmodule Menu do
  def limpar_tela() do
    IO.write("\e[H\e[2J")
  end

  def mostrar_mensagem_com_timer(msg, timer) do
    limpar_tela()
    IO.puts(msg)
    :timer.sleep(timer)
  end

  def init(alunos \\ []) do
    limpar_tela()

    { opcao, _} = IO.gets("
      1 - Cadastrar aluno
      2 - Listar alunos
      3 - Alterar aluno
      4 - Procurar aluno
      5 - Excluir aluno
      0 - Sair do programa
    ") |> String.trim() |> Integer.parse()

    case opcao do
      1 ->
        alunos = Classe.cadastrar_aluno(alunos)
        init(alunos)
      2 ->
        Classe.listar_alunos(alunos)
        init(alunos)
      3 ->
        alunos = Classe.alterar_aluno(alunos)
        init(alunos)
      4 ->
        Classe.buscar_e_mostrar_aluno(alunos)
        init(alunos)
      5 ->
        alunos = Classe.excluir_aluno(alunos)
        init(alunos)
      0 ->
        limpar_tela()
        IO.puts("Saindo do programa ...")
      _ ->
        mostrar_mensagem_com_timer("Opção inválida", 1000)
        init(alunos)
    end
  end
end

defmodule Classe do
  def cadastrar_aluno(alunos) do
    Menu.limpar_tela()
    id = DateTime.to_unix(DateTime.utc_now())
    nome = IO.gets("Digite o nome do aluno\n") |> String.trim()
    matricula = IO.gets("Digite a matricula do(a) #{nome}\n") |> String.trim()
    notas = captura_notas(nome)

    alunos = alunos ++ [
      %Aluno{
        id: id,
        nome: nome,
        matricula: matricula,
        notas: notas,
      }
    ]

    alunos
  end

  def alterar_aluno(alunos) do
    Menu.limpar_tela()

    {matricula, aluno} = buscar_aluno(alunos)
    if aluno == nil do
      Menu.mostrar_mensagem_com_timer("Aluno da matricula #{matricula}, não foi encontrado.", 2000)
      alunos
    else
      Menu.limpar_tela()
      mostrar_aluno(aluno)
      IO.puts("\n === Dados de alteração do aluno ===")
      nome = IO.gets("Digite o nome do aluno\n") |> String.trim()
      notas = captura_notas(nome)

      aluno_a_alterar = %Aluno{
        nome: nome,
        notas: notas
      }

      alunos = Enum.map(alunos, fn aluno ->
        if aluno.matricula == aluno_a_alterar.matricula do
          %Aluno{aluno | nome: aluno_a_alterar.nome, notas: aluno_a_alterar.notas}
        else
          aluno
        end
      end)

      Menu.mostrar_mensagem_com_timer("Aluno da matricula #{matricula}, foi alterado com sucesso.", 2000)
      alunos
    end
  end

  def excluir_aluno(alunos) do
    Menu.limpar_tela()

    {matricula, aluno} = buscar_aluno(alunos)
    if aluno == nil do
      Menu.mostrar_mensagem_com_timer("Aluno da matricula #{matricula}, não foi encontrado.", 2000)
      alunos
    else
      Menu.limpar_tela()
      mostrar_aluno(aluno)
      decisao = IO.gets("\nConfirma exclusão? (s|n)\n") |> String.trim()

      if decisao == "s" do
        alunos = List.delete(alunos, aluno)
        Menu.mostrar_mensagem_com_timer("Aluno da matricula #{matricula}, foi excluido com sucesso.", 2000)
        alunos
      else
        alunos
      end
    end
  end

  def buscar_e_mostrar_aluno(alunos) do
    {matricula, aluno} = buscar_aluno(alunos)
    if aluno == nil do
      Menu.mostrar_mensagem_com_timer("Aluno da matricula #{matricula}, não foi encontrado.", 2000)
      :ok
    else
      Menu.limpar_tela()

      mostrar_aluno(aluno)

      IO.gets("\nDigite enter para continuar ...")
    end
  end

  def buscar_aluno(alunos) do
    Menu.limpar_tela()

    matricula = IO.gets("Digite a matrícula do aluno\n") |> String.trim()

    if String.length(matricula) == 0 do
      Menu.mostrar_mensagem_com_timer("Matrícula não pode ser vazia.", 1000)
      { matricula, nil }
    else
      aluno = Enum.find(alunos, fn a -> a.matricula == matricula end)
      { matricula, aluno }
    end
  end

  def mostrar_aluno(aluno) do
    IO.puts("Id: #{ aluno.id }")
    IO.puts("Nome: #{ aluno.nome }")
    IO.puts("Matricula: #{ aluno.matricula }")
    notas = aluno.notas |> Enum.map(&Integer.to_string/1) |> Enum.join(", ")
    IO.puts("Notas: #{ notas }")
    IO.puts("Média: #{ AlunoServico.media(aluno) }")
  end

  def listar_alunos(alunos) do
    Menu.limpar_tela()

    if length(alunos) == 0 do
      Menu.mostrar_mensagem_com_timer("Nenhum aluno cadastrado.", 1000)
      :ok
    else
      IO.puts("=== Lista de alunos ===")
      Enum.each(alunos, fn aluno ->
        mostrar_aluno(aluno)
        IO.puts("\n")
      end)

      IO.gets("Digite enter para continuar ...")
    end
  end

  def captura_notas(nome, notas \\ []) do
    Menu.limpar_tela()

    { nota, _ } = IO.gets("Digite a nota do(a) #{nome}\n") |> String.trim() |> Integer.parse()

    notas_atualizadas = notas ++ [nota]

    opcao_str = IO.gets("
      Digite:
      0 - Para voltar ao cadastro
      1 - Para cadastrar uma nova nota
    ") |> String.trim()

    {opcao, _} = case Integer.parse(opcao_str) do
      :error -> {1, ""}
      result -> result
    end

    if opcao != 0 do
      captura_notas(nome, notas_atualizadas)
    else
      notas_atualizadas
    end
  end
end


ProgramaDoSergio.init()
