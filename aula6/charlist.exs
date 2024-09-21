nome = 'Danilo'
mensagem = 'Olá, #{nome}!'  # Isso é uma charlist
IO.puts(to_string(mensagem))  # Converte para string

IO.puts("-------------")
Enum.each('teste', fn char ->
  IO.puts("Caractere: #{List.to_string([char])} - Unicode: #{char}")
end)
result = Enum.map('teste', &(&1 + 1))  # Adiciona 1 ao valor de cada byte
IO.puts("-------------")
IO.puts(to_string(result))
IO.puts("-------------")
Enum.each(result, fn char ->
  IO.puts("Caractere: #{List.to_string([char])} - Unicode: #{char}")
end)
IO.puts("-------------")

# Loop sobre a charlist (lista de bytes)
Enum.each(mensagem, fn char ->
  IO.puts("Caractere: #{List.to_string([char])} - Unicode: #{char}")
end)

IO.puts("-------------")
Enum.each(String.to_charlist("Oláaa pessoal"), fn char -> # converter string em charlist
  IO.puts("Caractere: #{List.to_string([char])} - Unicode: #{char}")
end)
