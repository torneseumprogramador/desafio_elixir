defmodule UI.AlunoConsole do
  alias Negocio.Entidades.Aluno
  alias Negocio.Servicos.AlunoServico
  alias UI.Servicos.ConsoleServico
  alias Repositorios.PersistenciaRepo

  @nome_json "alunos.json"

  def cadastrar_aluno() do
    alunos = PersistenciaRepo.buscar(@nome_json, &AlunoServico.instancia/1)
    ConsoleServico.limpar_tela()

    nome = IO.gets("Digite o nome do aluno\n") |> String.trim()
    matricula = IO.gets("Digite a matricula do(a) #{nome}\n") |> String.trim()
    notas = captura_notas(nome)

    alunos = AlunoServico.incluir(
      alunos,
      %Aluno{
        nome: nome,
        matricula: matricula,
        notas: notas,
      }
    )

    PersistenciaRepo.salvar(alunos, @nome_json)
  end

  def alterar_aluno() do
    alunos = PersistenciaRepo.buscar(@nome_json, &AlunoServico.instancia/1)
    ConsoleServico.limpar_tela()

    {matricula, aluno} = buscar_aluno(alunos)
    if aluno == nil do
      ConsoleServico.mostrar_mensagem_com_timer("Aluno da matricula #{matricula}, não foi encontrado.", 2000)
    else
      ConsoleServico.limpar_tela()
      mostrar_aluno(aluno)
      IO.puts("\n === Dados de alteração do aluno ===")
      nome = IO.gets("Digite o nome do aluno\n") |> String.trim()
      notas = captura_notas(nome)

      aluno_a_alterar = %Aluno{
        nome: nome,
        notas: notas
      }

      alunos = AlunoServico.alterar_por_matricula(alunos, aluno_a_alterar)
      PersistenciaRepo.salvar(alunos, @nome_json)
      ConsoleServico.mostrar_mensagem_com_timer("Aluno da matricula #{matricula}, foi alterado com sucesso.", 2000)
    end
  end

  def excluir_aluno() do
    alunos = PersistenciaRepo.buscar(@nome_json, &AlunoServico.instancia/1)
    ConsoleServico.limpar_tela()

    {matricula, aluno} = buscar_aluno(alunos)
    if aluno == nil do
      ConsoleServico.mostrar_mensagem_com_timer("Aluno da matricula #{matricula}, não foi encontrado.", 2000)
    else
      ConsoleServico.limpar_tela()
      mostrar_aluno(aluno)
      decisao = IO.gets("\nConfirma exclusão? (s|n)\n") |> String.trim()

      if decisao == "s" do
        alunos = AlunoServico.excluir(alunos, aluno)
        PersistenciaRepo.salvar(alunos, @nome_json)
        ConsoleServico.mostrar_mensagem_com_timer("Aluno da matricula #{matricula}, foi excluido com sucesso.", 2000)
      end
    end
  end

  def buscar_e_mostrar_aluno() do
    alunos = PersistenciaRepo.buscar(@nome_json, &AlunoServico.instancia/1)

    {matricula, aluno} = buscar_aluno(alunos)
    if aluno == nil do
      ConsoleServico.mostrar_mensagem_com_timer("Aluno da matricula #{matricula}, não foi encontrado.", 2000)
      :ok
    else
      ConsoleServico.limpar_tela()

      mostrar_aluno(aluno)

      IO.gets("\nDigite enter para continuar ...")
    end
  end

  def buscar_aluno(alunos) do
    ConsoleServico.limpar_tela()

    matricula = IO.gets("Digite a matrícula do aluno\n") |> String.trim()

    if String.length(matricula) == 0 do
      ConsoleServico.mostrar_mensagem_com_timer("Matrícula não pode ser vazia.", 1000)
      { matricula, nil }
    else
      aluno = AlunoServico.buscar(alunos, matricula)
      { matricula, aluno }
    end
  end

  def mostrar_aluno(aluno) do
    IO.puts("Id: #{ aluno.id }")
    IO.puts("Nome: #{ aluno.nome }")
    IO.puts("Matricula: #{ aluno.matricula }")
    notas = aluno.notas |> Enum.map(&Integer.to_string/1) |> Enum.join(", ")
    IO.puts("Notas: #{ notas }")
    IO.puts("Média: #{ AlunoServico.media_formatada(aluno) }")
  end

  def listar_alunos() do
    alunos = PersistenciaRepo.buscar(@nome_json, &AlunoServico.instancia/1)
    ConsoleServico.limpar_tela()

    if length(alunos) == 0 do
      ConsoleServico.mostrar_mensagem_com_timer("Nenhum aluno cadastrado.", 1000)
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
    ConsoleServico.limpar_tela()

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
