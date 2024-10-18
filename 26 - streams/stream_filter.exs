stream = 1..100_000_000 |> Stream.map(&(&1 * 2)) |> Stream.filter(&(&1 < 50_000))
result = Enum.take(stream, 1000)

Enum.each(result, fn numero ->
  IO.puts(numero)
end)

# IO.inspect(result)
