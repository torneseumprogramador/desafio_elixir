defmodule Repositorios.PersistenciaRepo do
  @moduledoc """
  Modulo de persistencia de arquivo.json
  """

  @doc """
  Salva lista de struct com o nome do arquivo
    ## Exemplos
      iex> Repositorios.PersistenciaRepo.salvar(lista, "alunos.json")
  """
  def salvar(lista, nome, diretorio \\ "db") do
    json_string = lista |> Enum.map(&Map.from_struct/1) |> Jason.encode!()

    File.write("#{diretorio}/#{nome}", json_string)
  end

  @doc """
  Busca dados de alunos no arquivo.json e converte em uma lista de struct Aluno
    ## Exemplos
      iex> lista = Repositorios.PersistenciaRepo.buscar("alunos.json")
  """
  def buscar(nome, map_to_aluno, diretorio \\ "db") do
    case File.read("#{diretorio}/#{nome}") do
      {:ok, content} ->
        case Jason.decode(content) do
          {:ok, json_data} ->
            Enum.map(json_data, map_to_aluno)
          {:error, _} ->
            IO.puts("Erro ao decodificar JSON")
            nil
        end
      {:error, _} ->
        IO.puts("Erro ao ler o arquivo")
        nil
    end
  end
end
