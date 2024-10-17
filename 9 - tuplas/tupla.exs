##### criando uma tupla (é o mais proximo de um array no elixir. Elixir não tem array comum como existe em outras linguagens)
tupla = {:ok, "Sucesso", 200}
IO.puts(elem(tupla, 1))  # Retorna "Sucesso"
IO.inspect(tupla)  # {:ok, "Sucesso", 200}

##### adicionar da tupla
tupla_original = {:a, :b, :c}
novo_item = :d
# Convertendo a tupla para lista, adicionando o item, e convertendo de volta para tupla
nova_tupla = List.to_tuple(Tuple.to_list(tupla_original) ++ [novo_item])
IO.inspect(nova_tupla)
# Saída: {:a, :b, :c, :d}

##### atualização da tupla
nova_tupla = put_elem(tupla, 1, "Atualizado")
IO.inspect(nova_tupla)  # {:ok, "Atualizado", 200}

##### excluir elemento da tupla por indice
tupla_original = {:a, :b, :c}
# Índice que deseja remover
indice = 1
# Convertendo para lista, removendo o elemento, e reconvertendo para tupla
nova_lista = List.delete_at(Tuple.to_list(tupla_original), indice)
nova_tupla = List.to_tuple(nova_lista)
IO.inspect(nova_tupla)
# Saída: {:a, :c}

##### excluir item da tupla por valor
tupla_original = {:a, :b, :c}
# Valor que deseja remover
valor = :b
# Convertendo para lista, removendo o valor, e reconvertendo para tupla
nova_lista = List.delete(Tuple.to_list(tupla_original), valor)
nova_tupla = List.to_tuple(nova_lista)
IO.inspect(nova_tupla)
# Saída: {:a, :c}

##### verificar tamanho da tupla
IO.puts(tuple_size(tupla)) # Retorna 3


##### convertendo uma lista em tupla
lista = [1, 2, 3]
tupla = List.to_tuple(lista)
# {:ok, 2, 3}

##### convertendo uma tupla em list
tupla = {1, 2, 3}
lista = Tuple.to_list(tupla)
# [1, 2, 3]


###### adicionando um item no meio de uma lista
lista = [1, 3, 4, 6]
indice = 2
novo_elemento = 10

# Dividindo a lista em duas partes
{inicio, fim} = Enum.split(lista, indice)

# Concatenando as duas partes com o novo elemento no meio
nova_lista = inicio ++ [novo_elemento] ++ fim

IO.inspect(nova_lista)
# Saída: [1, 3, 10, 4, 6]


###### adicionando um item no meio de uma tupla
tupla = {1, 3, 4, 6}
indice = 2
novo_elemento = 10

# Convertendo a tupla para lista
lista = Tuple.to_list(tupla)

# Dividindo a lista em duas partes
{inicio, fim} = Enum.split(lista, indice)

# Concatenando as duas partes com o novo elemento no meio
nova_lista = inicio ++ [novo_elemento] ++ fim

# Convertendo de volta para tupla
nova_tupla = List.to_tuple(nova_lista)

IO.inspect(nova_tupla)
# Saída: {1, 3, 10, 4, 6}
