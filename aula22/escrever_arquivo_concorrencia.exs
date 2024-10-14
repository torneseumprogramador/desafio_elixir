defmodule ComConcorrencia do
  def escrever_arquivo do
    File.write!("numeros_com_concorrencia.txt", "")

    # Criar 10 processos, cada um escrevendo 100 números
    processos = for i <- 1..10 do
      spawn(fn -> escrever_numeros(i) end)
    end

    # Esperar até que todos os processos terminem
    Enum.each(processos, fn pid ->
      ref = Process.monitor(pid)
      receive do
        {:DOWN, ^ref, :process, ^pid, _reason} -> :ok
      end
    end)

    IO.puts("Escrita com concorrência concluída!")
  end

  defp escrever_numeros(parte) do
    inicio = (parte - 1) * 100 + 1
    fim = parte * 100

    # IO.puts("============ INICIO: #{inicio}, FIM: #{fim} ============")
    Enum.each(inicio..fim, fn numero ->
      # File.write!("numeros_com_concorrencia_#{inicio}_#{fim}.txt", "#{numero}\n", [:append])
      File.write!("numeros_com_concorrencia.txt", "#{numero}\n", [:append])
      :timer.sleep(100) # simular um processamento de 100 milisegundos
      IO.puts("Processo #{inspect(self())} escrevendo número #{numero}")
    end)
  end
end

# Executa a função
ComConcorrencia.escrever_arquivo()


defmodule LerArquivoOrdenar do
  def ler_e_ordenar_arquivo do
    # Ler o conteúdo do arquivo
    {:ok, conteudo} = File.read("numeros_com_concorrencia.txt")

    # Transformar o conteúdo em uma lista de números
    numeros =
      conteudo
      |> String.split("\n", trim: true) # Dividir o conteúdo em linhas
      |> Enum.map(&String.to_integer/1) # Converter cada linha para um inteiro

    # Ordenar os números
    numeros_ordenados = Enum.sort(numeros)

    # Exibir os números ordenados
    IO.puts("Números ordenados:")
    IO.inspect(numeros_ordenados)

    # Opcional: Salvar os números ordenados em um novo arquivo
    File.write!("numeros_com_concorrencia.txt", Enum.join(numeros_ordenados, "\n"))

    IO.puts("Números ordenados foram salvos em 'numeros_com_concorrencia.txt'")
  end
end

# Executa a função para ler e ordenar o arquivo
LerArquivoOrdenar.ler_e_ordenar_arquivo()
