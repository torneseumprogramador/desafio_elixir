Mix.install([{:jason, "~> 1.4"}])

defmodule StructTypedMacro do
  defmacro define_struct_from_json(file_path) do
    # Lendo o conteúdo do arquivo JSON no momento da compilação
    {:ok, json} = File.read(file_path)
    alunos = Jason.decode!(json)

    # Pegando as chaves do primeiro aluno para definir a struct
    keys = alunos |> List.first() |> Map.keys() |> Enum.map(&String.to_atom/1)

    # IO.puts("======keys=========[")
    # IO.inspect(keys)
    # IO.puts("]===============")

    # Definindo dinamicamente a struct com as chaves obtidas
    quote do
      defstruct unquote(keys)

      # Função para criar uma lista de alunos tipados a partir do JSON
      def get_list_from_json() do
        alunos = unquote(Macro.escape(alunos))

        # IO.puts("===============[")
        # IO.inspect(alunos)
        # IO.puts("]===============")

        # Converte cada mapa em uma struct Aluno
        Enum.map(alunos, fn aluno_map ->
          # IO.puts("=======aluno_map========[")
          # IO.inspect(aluno_map)
          # IO.puts("]===============")

          aluno_tipado = new(aluno_map)
          # IO.puts("=======aluno_tipado========[")
          # IO.inspect(aluno_tipado)
          # IO.puts("]===============")
          aluno_tipado
        end)
      end

      # Função para criar uma nova struct dinamicamente
      def new(aluno_params \\ %{}) do
        # IO.puts("======= aluno_params ========")
        # IO.inspect(aluno_params)
        # IO.puts("=============================")

        # Converte todas as chaves do mapa para átomos, se ainda não forem
        aluno_params_atom_keys =
          aluno_params
          |> Enum.into(%{}, fn {key, value} ->
            atom_key =
              case key do
                k when is_binary(k) -> String.to_atom(k)  # Se a chave for string, converte para atom
                k when is_atom(k) -> k                     # Se já for atom, mantém
              end

            {atom_key, value}
          end)

        # Cria a struct Aluno com as chaves em formato atom
        struct(__MODULE__, aluno_params_atom_keys)
      end
    end
  end
end

# defmodule Aluno do
#   defstruct [:id, :nome, :cpf, :matricula]
# end

# Usando a macro para definir a struct com base no arquivo JSON
defmodule Aluno do
  require StructTypedMacro
  StructTypedMacro.define_struct_from_json("alunos.json")
end


# defmodule Cliente do
#   defstruct [:id, :nome, :endereco]
# end
defmodule Usuario do
  require StructTypedMacro
  StructTypedMacro.define_struct_from_json("usuarios.json")
end


# Exemplo de uso
alunos = Aluno.get_list_from_json()
IO.inspect(alunos) # Exibe a lista de alunos

# Criando um novo aluno usando a struct gerada pela macro
aluno = Aluno.new(%{id: 1, nome: "Danilo", cpf: "12345678901"})
IO.inspect(aluno)  # Exibe a struct criada

aluno = Aluno.new(%{"id" => 1, "nome" => "Danilo", "cpf" => "12345678901"})
IO.inspect(aluno)  # Exibe a struct criada


IO.inspect(Usuario.new())
