
# se concentre somente no porque devemos utilizar o atom, ainda vamos estudar
# o if o def e o case

#### Como o código código está fora de um modulo, não irá funcionar
#### é somente um exemplo de como utilizar o atom

# def divide(a, b) do
#   if b == 0 do
#     {:error, :division_by_zero}
#   else
#     {:ok, a / b}
#   end
# end

# # { result, value } = divide(10, 2)
# # if result == :ok
# #   IO.puts("Resultado: #{value}")
# # else
# #   IO.puts("Erro: #{value}")
# # end

# result = divide(10, 2)
# case result do
#   {:ok, value} -> IO.puts("Resultado: #{value}")
#   {:error, reason} -> IO.puts("Erro: #{reason}")
# end

# # chave como string
# mapa = %{"nome" => "João", "idade" => 30}
# IO.puts(mapa["nome"])  # Acesso à chave do mapa

# # chave como atom
# mapa = %{nome: "João", idade: 30}
# IO.puts(mapa.nome)  # Acesso à chave do mapa


# # conversão para atom
# atom = :hello
# string = "hello"
# IO.puts(atom == String.to_atom(string))  # true


# atom_from_string = String.to_atom("hello")
# IO.puts(atom_from_string)  # :hello

# Isso falha se o átomo ainda não existir
atom_existing = String.to_existing_atom("ok") # to_existing_atom consegue validar atom reservados (:ok. :success, :error) caso não seja um atom válido dispara error

# require IEx; IEx.pry() # debugger
IO.puts(atom_existing)  # :ok


IO.puts(is_atom(:apple))  # true
IO.puts(is_atom("apple"))  # false
IO.puts(is_boolean(:true))  # true

# comparando atom
atom = :hello
string = "hello"
IO.puts(atom == String.to_atom(string))  # true

# convertendo atom para string
string_from_atom = Atom.to_string(:world)
IO.puts(string_from_atom)  # "world"
