# Criando um novo processo que apenas imprime uma mensagem
pid = spawn(fn -> IO.puts("Hello from a new process!") end)


IO.puts("==============[Kill pid]==================")
defmodule Infinito do
  def loop() do
    IO.puts("Running...")
    :timer.sleep(1000)  # Pausa o loop por 1 segundo entre cada iteração
    loop()
  end
end

# Cria o processo com o loop infinito
pid = spawn(fn -> Infinito.loop() end)

# Aguarda 5 segundos (5000 milissegundos) antes de matar o processo
Process.sleep(5000)

# Mata o processo após o timer
IO.puts("Encerrando processo ...")
Process.exit(pid, :kill)
IO.puts("=========================================")
