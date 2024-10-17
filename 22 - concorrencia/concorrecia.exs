# Função que descreve o comportamento de um processo
defmodule ExemploProcesso do
  def iniciar_processo do
    # Receberá mensagens até que a condição seja satisfeita
    receive do
      {mensagem, remetente} ->
        IO.puts("Recebi a mensagem: #{mensagem}")
        # Enviar uma resposta de volta ao remetente
        send(remetente, {:ok, "Mensagem processada com sucesso! (2)"})
    end
  end
end

# Iniciar o processo
pid = spawn(ExemploProcesso, :iniciar_processo, []) # é o nosso ator (processo paralelo)

# Enviar uma mensagem para o processo
send(pid, {"Olá, processo! (1)", self()})

# Aguardar pela resposta do processo
receive do
  {:ok, resposta} ->
    IO.puts("Resposta recebida: #{resposta}")
after
  5000 -> IO.puts("Tempo esgotado para receber resposta.")
end
