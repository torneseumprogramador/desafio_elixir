defmodule SemConcorrencia do
  def escrever_arquivo do
    File.write!("numeros_sem_concorrencia.txt", "")

    Enum.each(1..1000, fn numero ->
      File.write!("numeros_sem_concorrencia.txt", "#{numero}\n", [:append])
      :timer.sleep(100) # simular um processamento de 100 milisegundos
      IO.puts("Escrevendo número #{numero}")
    end)

    IO.puts("Escrita sem concorrência concluída!")
  end
end

# Executa a função
SemConcorrencia.escrever_arquivo()
