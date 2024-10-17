numeros = [1, 2, 3, 4, 5]
quadrados = for n <- numeros, do: n * n
# quadrados = Enum.map(numeros, fn x -> x * 2 end) # Output: [2, 4, 6]
IO.inspect(quadrados) # Saída: [1, 4, 9, 16, 25]


numeros = [1, 2, 3, 4, 5]
pares = for n <- numeros, rem(n, 2) == 0, do: n
# pares = Enum.filter(numeros, fn x -> rem(x, 2) == 0 end)
IO.inspect(pares) # Saída: [2, 4]


listas = for x <- [1, 2], y <- [3, 4], do: {x, y}
IO.inspect(listas) # Saída: [{1, 3}, {1, 4}, {2, 3}, {2, 4}]

pares = for n <- 1..4, rem(n, 2) == 0, into: %{}, do: {n, n * n}
IO.inspect(pares) # Saída: %{2 => 4, 4 => 16}
