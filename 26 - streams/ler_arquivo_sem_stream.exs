defmodule LerArquivoSemStream do
  def ler_frases(file_path) do
    case File.read(file_path) do
      {:ok, conteudo} ->
        conteudo
        |> String.split("\n", trim: true)
        |> Enum.with_index(1)  # Adiciona um índice a cada linha, começando de 1
        |> Enum.each(fn {line, index} ->
          IO.binwrite("Linha #{index}: #{line}\n---\n")
        end)

      {:error, reason} ->
        IO.puts("Erro ao ler o arquivo: #{reason}")
    end
  end
end

# Executa a função com o arquivo grande
LerArquivoSemStream.ler_frases("frases.txt")
