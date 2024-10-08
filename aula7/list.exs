#### No elixir não existe o array, utilizamos listas encadeadas ou tuplas

lista = [1, 2, 3, 4] # define um list
IO.puts(Enum.count(lista)) # conta a quantidade

lista = [1, "2", true, 4.4] # define um list com tipos diferentes
IO.puts(Enum.count(lista)) # conta a quantidade

lista = [1, 2, 3, 4]
IO.inspect(lista)
primeiro = hd(lista) # 1 # retorna o primeiro da lista
IO.inspect(primeiro)
lista = tl(lista) # [2, 3, 4] # dados sem o primeiro da lista
IO.inspect(lista)


###### No Elixir, listas são imutáveis, o que significa que você não pode modificar diretamente uma lista (como faria em linguagens com lists mutáveis). Retorna uma lista nova
lista = [2, 3, 4]
lista = [1 | lista]  # Adiciona o valor 1 no início da lista
IO.inspect(lista)
# Output: [1, 2, 3, 4]

lista = [1, 2, 3]
lista = lista ++ [4]  # Adiciona o valor 4 no final da lista
IO.inspect(lista)
# Output: [1, 2, 3, 4]

lista = [1, 2, 3]
lista = lista ++ [4,5]  # Adiciona o valor 4 no final da lista
IO.inspect(lista)
# Output: [1, 2, 3, 4, 5]


###### remover item da lista
lista = [1, 2, 3]
[maca | resto] = lista
IO.inspect(maca)   # Output: 1 (valor removido)
IO.inspect(resto)  # Output: [2, 3] (nova lista sem o primeiro valor)

lista = [1, 2, 3, 2, 4]
lista = List.delete(lista, 2)
IO.inspect(lista)
# Output: [1, 3, 2, 4] (remove apenas a primeira ocorrência de 2)

lista = [1, 2, 3, 4]
lista = List.delete_at(lista, -1)
IO.inspect(lista)
# Output: [1, 2, 3] (remove o último elemento)





###### Enum.at - Captura informação de dentro de um list por indice
lista = ["maçã", "banana", "laranja", "melancia", "limao"]
IO.inspect(Enum.at(lista, 1)) # banana
IO.inspect(Enum.at(lista, 0)) # maça
IO.inspect(Enum.at(lista, 4)) # limao
IO.inspect(Enum.at(lista, 5)) # Se não achar pelo indice retorna nil
IO.inspect(Enum.at(lista, 5, :nao_encontrado)) # Se não achar pelo indice retorna um atom ao invés de um nil


###### Trabalhando com matriz (um list dentro de um list)
lista = [[1, "maçã"], [2,"banana"], [3,"laranja"], [4,"melancia"], [5,"limao"]]
[codigo, produto] = Enum.at(lista, 0) # [1, "maçã"]
IO.inspect(codigo) # 1
IO.inspect(produto) # "maçã"

res = Enum.at( Enum.at(lista, 0), 1 ) # maça
IO.inspect(res)



###### transformar o list retornando um novo list tratado
lista = [1, 2, 3]
re = Enum.map(lista, fn x -> x * 2 end) # Output: [2, 4, 6]
IO.inspect(re)

###### transformar o list retornando um novo list tratado
lista = [1, 2, 3]
re = Enum.map(lista, fn x -> "Numero tratado: #{x}" end) # Output: ["Numero tratado: 2", "Numero tratado: 4", Numero tratado: 6"]
IO.inspect(re)

###### retona a lista filtrada de números pares (rem(x, 2) == 0) calculo para saber numero par
lista = [1, 2, 3, 4, 5]
re = Enum.filter(lista, fn x -> rem(x, 2) == 0 end) # Output: [2, 4]
IO.inspect(re)

###### retona a lista filtrada de por nome
lista = ["maçã", "banana", "laranja", "melancia", "limao"]
re = Enum.filter(lista, fn x -> String.contains?(x, "an") end)
IO.inspect(re)

###### retona o elemento encontrado
lista = ["maçã", "banana", "laranja", "melancia", "limao"]
re = Enum.find(lista, fn x -> String.contains?(x, "laranja") end)
IO.inspect(re)

###### retona o elemento encontrado
lista = ["maçã", "banana", "laranja", "melancia", "limao"]
re = Enum.find(lista, fn x -> String.contains?(x, "morango") end)
IO.inspect(re)


###### espalha conteúdo em variáveis
lista = ["maçã", "banana", "laranja"]
[maca, banana, laranja] = lista # espalhando itens do list em variáveis
IO.inspect(maca)
IO.inspect(banana)
IO.inspect(laranja)


###### retorna um item fazendo uma operação
lista = [1, 2, 3]
soma = Enum.reduce(lista, 0, fn x, y -> x + y end)
# Output: 6
IO.inspect(soma)


###### altera a ordem dos itens na lista
lista = [1, 2, 3]
IO.inspect(Enum.reverse(lista)) # Output: [3, 2, 1]


###### juntar dois lists
lista1 = [1, 2]
lista2 = [3, 4]
IO.inspect( Enum.concat([lista1, lista2]) )# Output: [1, 2, 3, 4]


###### retorna uma lista unica (tira os repetidos)
lista = [1, 2, 2, 3, 3, 3]
IO.inspect( Enum.uniq(lista) )# Output: [1, 2, 3]

###### retona uma lista sem os nil
lista = [1, 2, nil, 3, nil, 3]
IO.inspect(Enum.filter(lista, fn x -> x != nil end))  # Output: [1, 2, 3, 3]

###### retona uma lista sem os nil
lista = [1, 2, nil, 3, nil, 3]
IO.inspect(Enum.reject(lista, fn x -> x == nil end))  # Output: [1, 2, 3, 3]
IO.inspect(Enum.reject(lista, fn x -> is_nil(x) end))  # Output: [1, 2, 3, 3]


###### ordenar dados de uma lista em ordem crescente
lista = [3, 1, 2]
IO.inspect( Enum.sort(lista) ) # Output: [1, 2, 3]

###### ordenar dados de uma lista em ordem decrescente
lista = [3, 1, 2]
IO.inspect( Enum.reverse(Enum.sort(lista)) ) # Output: [1, 2, 3]

###### ordenar dados de uma lista em ordem decrescente mais efetiva
lista = [1, 4, 3, 2, 5]
IO.inspect(Enum.sort(lista, &>=/2))
# Output: [5, 4, 3, 2, 1]



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



#### Loop com each ####
numeros = [2,3,5,6,8,9]
Enum.each(numeros, fn numero ->
  IO.puts("Numero: #{ numero }")
end)
