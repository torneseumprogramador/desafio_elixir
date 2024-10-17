
# require IEx; IEx.pry() # debugger


#### Estágios da conversão ####
# numero1 = IO.gets("Digite o primeiro número\n")
# numero1 = String.trim(numero1)
# numero1 = String.to_integer(numero1)

numero1 = IO.gets("Digite o primeiro número\n") |> String.trim() |> String.to_integer()
numero2 = IO.gets("Digite o segundo número\n") |> String.trim() |> String.to_integer()

# numero1 = IO.gets("Digite o primeiro número\n")
# numero2 = IO.gets("Digite o segundo número\n")

resultado = rem(numero1, numero2)
# resultado = String.to_integer(String.trim(numero1)) + String.to_integer(String.trim(numero2))

IO.puts("O Resultadodo do resto é igual a: #{resultado}")
