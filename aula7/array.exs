lista = [1, 2, 3, 4] # define um array
IO.puts(Enum.count(lista)) # conta a quantidade

lista = [1, "2", true, 4.4] # define um array com tipos diferentes
IO.puts(Enum.count(lista)) # conta a quantidade

lista = [1, 2, 3, 4]
IO.inspect(lista)
primeiro = hd(lista) # 1 # retorna o primeiro da lista
IO.inspect(primeiro)
lista = tl(lista) # [2, 3, 4] # dados sem o primeiro da lista
IO.inspect(lista)


# Enum.at - Captura informação de dentro de um array por indice
lista = ["maçã", "banana", "laranja", "melancia", "limao"]
IO.inspect(Enum.at(lista, 1)) # banana
IO.inspect(Enum.at(lista, 0)) # maça
IO.inspect(Enum.at(lista, 4)) # limao
IO.inspect(Enum.at(lista, 5)) # Se não achar pelo indice retorna nil
IO.inspect(Enum.at(lista, 5, :nao_encontrado)) # Se não achar pelo indice retorna um atom ao invés de um nil


# Trabalhando com matriz (um array dentro de um array)
lista = [[1, "maçã"], [2,"banana"], [3,"laranja"], [4,"melancia"], [5,"limao"]]
[codigo, produto] = Enum.at(lista, 0) # [1, "maçã"]
IO.inspect(codigo) # 1
IO.inspect(produto) # "maçã"

res = Enum.at( Enum.at(lista, 0), 1 ) # maça
IO.inspect(res)



# transformar o array retornando um novo array tratado
lista = [1, 2, 3]
re = Enum.map(lista, fn x -> x * 2 end) # Output: [2, 4, 6]
IO.inspect(re)

# transformar o array retornando um novo array tratado
lista = [1, 2, 3]
re = Enum.map(lista, fn x -> "Numero tratado: #{x}" end) # Output: ["Numero tratado: 2", "Numero tratado: 4", Numero tratado: 6"]
IO.inspect(re)

# retona a lista filtrada de números pares (rem(x, 2) == 0) calculo para saber numero par
lista = [1, 2, 3, 4, 5]
re = Enum.filter(lista, fn x -> rem(x, 2) == 0 end) # Output: [2, 4]
IO.inspect(re)

# retona a lista filtrada de por nome
lista = ["maçã", "banana", "laranja", "melancia", "limao"]
re = Enum.filter(lista, fn x -> String.contains?(x, "an") end)
IO.inspect(re)

# retona o elemento encontrado
lista = ["maçã", "banana", "laranja", "melancia", "limao"]
re = Enum.find(lista, fn x -> String.contains?(x, "laranja") end)
IO.inspect(re)

# retona o elemento encontrado
lista = ["maçã", "banana", "laranja", "melancia", "limao"]
re = Enum.find(lista, fn x -> String.contains?(x, "morango") end)
IO.inspect(re)


# espalha conteúdo em variáveis
lista = ["maçã", "banana", "laranja"]
[maca, banana, laranja] = lista # espalhando itens do array em variáveis
IO.inspect(maca)
IO.inspect(banana)
IO.inspect(laranja)


# retorna um item fazendo uma operação
lista = [1, 2, 3]
soma = Enum.reduce(lista, 0, fn x, y -> x + y end)
# Output: 6
IO.inspect(soma)


# altera a ordem dos itens na lista
lista = [1, 2, 3]
IO.inspect(Enum.reverse(lista)) # Output: [3, 2, 1]


# juntar dois arrays
lista1 = [1, 2]
lista2 = [3, 4]
IO.inspect( Enum.concat([lista1, lista2]) )# Output: [1, 2, 3, 4]


# retorna uma lista unica (tira os repetidos)
lista = [1, 2, 2, 3, 3, 3]
IO.inspect( Enum.uniq(lista) )# Output: [1, 2, 3]

# retona uma lista sem os nil
lista = [1, 2, nil, 3, nil, 3]
IO.inspect(Enum.filter(lista, fn x -> x != nil end))  # Output: [1, 2, 3, 3]

# retona uma lista sem os nil
lista = [1, 2, nil, 3, nil, 3]
IO.inspect(Enum.reject(lista, fn x -> x == nil end))  # Output: [1, 2, 3, 3]
IO.inspect(Enum.reject(lista, fn x -> is_nil(x) end))  # Output: [1, 2, 3, 3]


# ordenar dados de uma lista em ordem crescente
lista = [3, 1, 2]
IO.inspect( Enum.sort(lista) ) # Output: [1, 2, 3]

# ordenar dados de uma lista em ordem decrescente
lista = [3, 1, 2]
IO.inspect( Enum.reverse(Enum.sort(lista)) ) # Output: [1, 2, 3]

# ordenar dados de uma lista em ordem decrescente mais efetiva
lista = [1, 4, 3, 2, 5]
IO.inspect(Enum.sort(lista, &>=/2))
# Output: [5, 4, 3, 2, 1]
