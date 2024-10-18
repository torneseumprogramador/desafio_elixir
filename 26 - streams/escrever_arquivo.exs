defmodule EscreverFrase do
  @frase "A nível organizacional, o novo modelo estrutural aqui preconizado não pode mais se dissociar da gestão inovadora da qual fazemos parte.\n"
  @threads 30

  def escrever_frase_arquivo(quantidade \\ 1_000_000) do
    # Dividimos a quantidade total entre as threads
    por_thread = div(quantidade, @threads)

    # Criamos as tarefas assíncronas
    tasks = for _ <- 1..@threads do
      Task.async(fn ->
        # Cada tarefa vai abrir o arquivo em modo de append e escrever sua parte
        File.open!("frases.txt", [:append, :utf8], fn file ->
          for _ <- 1..por_thread do
            IO.write(file, @frase)
          end
        end)
      end)
    end

    # Aumentamos o timeout para 60 segundos
    Enum.each(tasks, fn task -> Task.await(task, 120_000) end)

    IO.puts("Escrita concorrente no arquivo concluída!")
  end
end

# Executa a função
EscreverFrase.escrever_frase_arquivo(10_000_000)
