range = 1..100_000_000
result = range
         |> Enum.map(&(&1 * 2))          # Multiplica cada número por 2
         |> Enum.filter(&(&1 < 50_000))  # Filtra apenas os números menores que 50.000
         |> Enum.take(1000)                # Pega os primeiros 80 números

Enum.each(result, fn numero ->
  IO.puts(numero)
end)
# IO.inspect(result)
