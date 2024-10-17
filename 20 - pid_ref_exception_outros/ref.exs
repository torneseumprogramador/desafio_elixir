# Criando uma referência única
ref = make_ref()

# Verificando se é uma referência
IO.puts(is_reference(ref))  # true


IO.puts("==============[Exemplo utilizando conceito de mensageria com arquivo]==================")
defmodule FileWatcher do
  @file_path "teste.txt"

  def start do
    watch_file()
  end

  defp watch_file do
    ref = make_ref()  # Gera uma referência única para cada ciclo de leitura
    case File.read(@file_path) do
      {:ok, content} when content != "" ->
        IO.puts("File content (ref: #{inspect(ref)}): #{content}")
      {:ok, ""} ->
        IO.puts("The file is empty (ref: #{inspect(ref)}), trying again...")
        Process.sleep(2_000)
        watch_file()
      {:error, _reason} ->
        IO.puts("File does not exist or cannot be read (ref: #{inspect(ref)}), trying again...")
        Process.sleep(2_000)
        watch_file()
    end

    IO.puts("ref chamada da função: #{inspect(ref)}")
  end
end

FileWatcher.start()
