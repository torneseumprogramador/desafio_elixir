
pago = IO.gets("Digite o valor pago pelo cliente\n") |> String.trim() |> String.to_integer()
produto = IO.gets("Digite o valor do produto\n") |> String.trim() |> String.to_integer()

troco = pago - produto
IO.puts("O troco será de: #{troco}")
