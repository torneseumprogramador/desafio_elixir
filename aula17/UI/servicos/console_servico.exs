defmodule ConsoleServico do
  def limpar_tela() do
    IO.write("\e[H\e[2J")
  end

  def mostrar_mensagem_com_timer(msg, timer) do
    limpar_tela()
    IO.puts(msg)
    :timer.sleep(timer)
  end
end
