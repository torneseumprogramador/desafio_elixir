defmodule Repositorios.PersistenciaRepo do
  alias Negocio.Entidades.Aluno
  @moduledoc """
  Modulo de persistencia de arquivo.json
  """

  @doc """
  Salva lista de struct com o nome do arquivo
    ## Exemplos
      iex> Repositorios.PersistenciaRepo.salvar(lista, "alunos.json")
  """
  def salvar(lista, nome) do
    json_string = lista |> Enum.map(&Map.from_struct/1) |> Jason.encode!()

    File.write("db/#{nome}", json_string)
  end

  @doc """
  Busca dados de alunos no arquivo.json e converte em uma lista de struct Aluno
    ## Exemplos
      iex> lista = Repositorios.PersistenciaRepo.buscar("alunos.json")
  """
  def buscar(nome) do
    case File.read("db/#{nome}") do
      {:ok, content} ->
        case Jason.decode(content) do
          {:ok, json_data} ->
            Enum.map(json_data, &map_to_aluno/1)
          {:error, _} ->
            IO.puts("Erro ao decodificar JSON")
        end
      {:error, _} ->
        IO.puts("Erro ao ler o arquivo")
    end
  end

  defp map_to_aluno(map) do
    %Aluno{
      id: map["id"],
      nome: map["nome"],
      matricula: map["matricula"],
      notas: map["notas"]
    }
  end
end
