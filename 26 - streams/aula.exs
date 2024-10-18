stream = Stream.iterate(0, &(&1 + 1))
even_numbers = stream |> Stream.filter(&rem(&1, 2) == 0) |> Enum.take(10)
IO.inspect(even_numbers)
