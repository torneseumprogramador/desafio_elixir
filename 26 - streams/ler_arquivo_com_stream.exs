defmodule LerArquivo do
  def ler_frases_stream(file_path) do
    File.stream!(file_path)
    |> Stream.with_index(1)  # Adiciona um índice a cada linha, começando de 1
    |> Stream.each(fn {line, index} ->
      # Usando IO.binwrite para evitar erros de codificação
      IO.binwrite("Linha #{index}: #{line}\n---\n")
    end)
    |> Stream.run()  # Executa o stream
  end
end

# Executa a função com o arquivo grande
LerArquivo.ler_frases_stream("frases.txt")
