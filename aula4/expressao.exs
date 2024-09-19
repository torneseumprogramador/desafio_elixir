IO.puts("
Vamos executar a expressão abaixo:
(10 + x * y - (8 * 6) / 7 + y * (z - 3))
")

x = IO.gets("Digite o x\n") |> String.trim() |> String.to_integer()
y = IO.gets("Digite o y\n") |> String.trim() |> String.to_integer()
z = IO.gets("Digite o z\n") |> String.trim() |> String.to_integer()

IO.puts("
A expressão ficou assim:
(10 + #{x} * #{y} - (8 * 6) / 7 + #{y} * (#{z} - 3))
")

resultado = (10 + x * y - (8 * 6) / 7 + y * (z - 3))

IO.puts("O Resultado da expressão é igual a: #{resultado}")
