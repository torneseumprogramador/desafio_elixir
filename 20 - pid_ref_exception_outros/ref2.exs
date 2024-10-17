defmodule FileWatcher do
  @file_path "teste.txt"

  def start do
    # Inicia o processo de monitoramento do arquivo e o processo de escuta de mensagens
    pid = spawn_link(fn -> listen_for_changes() end)
    pid2 = spawn_link(fn -> listen_for_changes_nova() end)
    watch_file(pid, pid2)
  end

  defp watch_file(pid, pid2) do
    ref = make_ref()  # Gera uma referência única para cada ciclo de leitura

    case File.read(@file_path) do
      {:ok, content} when content != "" ->
        IO.puts("File content (ref: #{inspect(ref)}): #{content}")
        send(pid, {:file_updated, ref, content}) # envia mensagem para o receive independente do nome da função
        send(pid2, {:file_updated, ref, content, "Danilo"}) # envia mensagem para o receive independente do nome da função
      {:ok, ""} ->
        IO.puts("The file is empty (ref: #{inspect(ref)}), trying again...")
        Process.sleep(2_000)
        watch_file(pid, pid2)
      {:error, _reason} ->
        IO.puts("File does not exist or cannot be read (ref: #{inspect(ref)}), trying again...")
        Process.sleep(2_000)
        watch_file(pid, pid2)
    end
  end

  defp listen_for_changes do
    receive do
      {:file_updated, ref, content} ->
        IO.puts("[Função listen_for_changes] - Received message with ref #{inspect(ref)}: Content is '#{content}'")
    after
      10_000 ->
        IO.puts("[Função listen_for_changes] - No file updates received within 10 seconds, still waiting...")
    end

    listen_for_changes()
  end

  defp listen_for_changes_nova do
    receive do
      {:file_updated, ref, content, nome} ->
        IO.puts("[Função listen_for_changes_nova] - Received message with ref #{inspect(ref)}: Content is '#{content}' - nome: #{nome}")
    after
      10_000 ->
        IO.puts("[Função listen_for_changes_nova] - No file updates received within 10 seconds, still waiting...")
    end

    IO.puts("testeseeeee .....")
    Process.sleep(2_000)
    listen_for_changes()
  end
end

FileWatcher.start()
