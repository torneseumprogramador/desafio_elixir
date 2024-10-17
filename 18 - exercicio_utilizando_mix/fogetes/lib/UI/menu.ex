defmodule UI.Menu do
  alias UI.Servicos.ConsoleServico
  alias UI.AlunoConsole

  def init() do
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
        AlunoConsole.cadastrar_aluno()
        init()
      2 ->
        AlunoConsole.listar_alunos()
        init()
      3 ->
        AlunoConsole.alterar_aluno()
        init()
      4 ->
        AlunoConsole.buscar_e_mostrar_aluno()
        init()
      5 ->
        AlunoConsole.excluir_aluno()
        init()
      0 ->
        ConsoleServico.limpar_tela()
        IO.puts("Saindo do programa ...")
      _ ->
        ConsoleServico.mostrar_mensagem_com_timer("Opção inválida", 1000)
        init()
    end
  end
end
