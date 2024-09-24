{ numero, _ } = IO.gets("Digite o numero da sorte\n") |> String.trim() |> Integer.parse()

# if numero == 8 do
#   IO.puts("Parabéns vc acertou o número da sorte ( #{numero} )")
# else
#   IO.puts("Infelizmente este não é o número da sorte ( #{numero} )")
# end

# em casos de else if, precisa utilizar o cond "elixir não tem else if na sintaxe"
# cond do
#   numero == 8 -> IO.puts("Parabéns vc acertou o número da sorte ( #{numero} )")
#   numero == 7 -> IO.puts("Parabéns vc acertou o outro número da sorte ( #{numero} )")
#   true -> IO.puts("Infelizmente este não é o número da sorte ( #{numero} )")
# end

#### cond = else if ####

# cond do
#   numero == 8 ->
#     IO.puts("Parabéns, você acertou o número da sorte!")
#     IO.puts("Número escolhido: #{numero}")

#   numero == 7 ->
#     IO.puts("Parabéns, você acertou o outro número da sorte!")
#     IO.puts("Número da sorte: #{numero}")

#   true ->
#     IO.puts("Infelizmente este não é o número da sorte.")
#     IO.puts("Você escolheu o número: #{numero}")
# end

# if numero == 8 || numero == 7 do
#   IO.puts("Parabéns vc acertou o número da sorte ( #{numero} )")
# else
#   IO.puts("Infelizmente este não é o número da sorte ( #{numero} )")
# end

# if numero == 8 or numero == 7 do
#   IO.puts("Parabéns vc acertou o número da sorte ( #{numero} )")
# else
#   IO.puts("Infelizmente este não é o número da sorte ( #{numero} )")
# end

# if numero >= 7 && numero <= 8 do
#   IO.puts("Parabéns vc acertou o número da sorte ( #{numero} )")
# else
#   IO.puts("Infelizmente este não é o número da sorte ( #{numero} )")
# end

# if numero >= 7 and numero <= 8 do
#   IO.puts("Parabéns vc acertou o número da sorte ( #{numero} )")
# else
#   IO.puts("Infelizmente este não é o número da sorte ( #{numero} )")
# end

# if (numero >= 6 && numero <= 9) || (numero == 15 || numero == 18) do
#   IO.puts("Parabéns vc acertou o número da sorte ( #{numero} )")
# else
#   IO.puts("Infelizmente este não é o número da sorte ( #{numero} )")
# end

# cond do
#   (numero >= 8 && numero <= 10) ->
#     IO.puts("Parabéns, você acertou o número da sorte!")
#     IO.puts("Número escolhido: #{numero}")

#   (numero == 7 || numero == 17) ->
#     IO.puts("Parabéns, você acertou o outro número da sorte!")
#     IO.puts("Número da sorte: #{numero}")

#   true ->
#     IO.puts("Infelizmente este não é o número da sorte.")
#     IO.puts("Você escolheu o número: #{numero}")
# end

# cond do
#   (numero >= 8 and numero <= 10) ->
#     IO.puts("Parabéns, você acertou o número da sorte!")
#     IO.puts("Número escolhido: #{numero}")

#   (numero == 7 or numero == 17) ->
#     IO.puts("Parabéns, você acertou o outro número da sorte!")
#     IO.puts("Número da sorte: #{numero}")

#   true ->
#     IO.puts("Infelizmente este não é o número da sorte.")
#     IO.puts("Você escolheu o número: #{numero}")
# end


#### case ####

# case numero do
#   1 ->
#     IO.puts("Parabéns, você acertou o número da sorte!")
#     IO.puts("Número escolhido: #{numero}")
#   10 ->
#     IO.puts("Parabéns, você acertou o número da sorte!")
#     IO.puts("Número escolhido: #{numero}")
#   _ ->
#     IO.puts("Infelizmente este não é o número da sorte.")
#     IO.puts("Você escolheu o número: #{numero}")
# end

### case com ( guard clauses (cláusulas de guarda) ) ####
case numero do
  n when n == 1 or n == 10 ->
    IO.puts("Parabéns, você acertou o número da sorte!")
    IO.puts("Número escolhido: #{n}")

  n when n > 10 and n < 20 ->
    IO.puts("O número está entre 10 e 20!")
    IO.puts("Número escolhido: #{n}")

  _ ->
    IO.puts("Infelizmente este não é o número da sorte.")
    IO.puts("Você escolheu o número: #{numero}")
end
