# Criando e lançando uma exceção
try do
  # .....
  raise "This is an error!"
rescue
  e in RuntimeError -> IO.puts("Caught a RuntimeError: #{e.message}")
end

# Definindo uma exceção personalizada
defmodule MyError do
  defexception message: "An error occurred"
end

# Lançando a exceção personalizada
try do
  raise MyError, message: "Custom error message"
rescue
  e in MyError -> IO.puts("Caught MyError: #{e.message}")
end



# Exemplo com try, rescue e finally
try do
  # Lançando uma exceção personalizada
  raise MyError, message: "Custom error message"
rescue
  # Capturando a exceção MyError
  e in MyError -> IO.puts("Caught MyError 2222: #{e.message}")
after
  # Código no bloco 'after' sempre será executado, mesmo que ocorra uma exceção
  IO.puts("This runs no matter what (finally equivalent).")
end
