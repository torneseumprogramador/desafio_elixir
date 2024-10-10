# Criando um range
range = 1..5

# Iterando sobre um range
Enum.each(range, fn num -> IO.puts(num) end)

# Verificando se um número está no range
IO.puts(3 in range)  # true


sucesso_http = 200..299
created = 201
IO.puts(created in sucesso_http)  # true
