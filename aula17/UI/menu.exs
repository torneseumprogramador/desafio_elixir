Code.require_file("servicos/console_servico.exs", __DIR__)
Code.require_file("aluno_console.exs", __DIR__)


defmodule Menu do
  def init(alunos \\ []) do
    ConsoleServico.limpar_tela()

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
        alunos = AlunoConsole.cadastrar_aluno(alunos)
        init(alunos)
      2 ->
        AlunoConsole.listar_alunos(alunos)
        init(alunos)
      3 ->
        alunos = AlunoConsole.alterar_aluno(alunos)
        init(alunos)
      4 ->
        AlunoConsole.buscar_e_mostrar_aluno(alunos)
        init(alunos)
      5 ->
        alunos = AlunoConsole.excluir_aluno(alunos)
        init(alunos)
      0 ->
        ConsoleServico.limpar_tela()
        IO.puts("Saindo do programa ...")
      _ ->
        ConsoleServico.mostrar_mensagem_com_timer("Opção inválida", 1000)
        init(alunos)
    end
  end
end
