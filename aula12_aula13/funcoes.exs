# #### função simples #####

# defmodule Math do
#   def sum(a, b) do
#     a + b
#   end
# end

# # Testando:
# IO.puts Math.sum(4, 5)  # Saída: 9


# ##### versão tratando parametro ####
# # defmodule Math do
# #   def sum(a, b) do
# #     if not is_integer(a) or not is_integer(b) do
# #       0
# #     else
# #       a + b
# #     end
# #   end
# # end



# #### Funções com Guard Clauses #####

# defmodule MathGuard do
#   def multiply(a, b) when is_integer(a) and is_integer(b) do
#     a * b
#   end

#   def multiply(a, b) when is_float(a) and is_float(b) do
#     IO.puts("Multiplicando números de ponto flutuante")
#     a * b
#   end
# end

# # Testando:
# IO.puts MathGuard.multiply(2, 3)       # Saída: 6
# IO.puts MathGuard.multiply(2.5, 3.0)   # Saída: "Multiplicando números de ponto flutuante", 7.5
# # IO.puts MathGuard.multiply("2", "5")   # Saída: (FunctionClauseError) no function clause matching in MathGuard.multiply/2
# # IO.puts MathGuard.multiply("2", 5)   # Saída:(FunctionClauseError) no function clause matching in MathGuard.multiply/2


# ##### Função recursiva ######

# defmodule MathRecursivaWhile do
#   def while(0), do: IO.puts("O número: 1") # tratamento para que a função possa funcionar se o valor estiver fora do guard
#   def while(n) when n > 0 do # função com guard, caso não seja <= 0 dispara exception
#     IO.puts("O número: #{n}")
#     while(n - 1)
#   end
# end

# # Testando:
# MathRecursivaWhile.while(10)




# defmodule MathRecursivaWhileAsc do
#   def while(10), do: IO.puts("O número: 10") # tratamento para que a função possa funcionar se o valor estiver fora do guard
#   def while(n) when n < 10 do # função com guard, caso não seja <= 0 dispara exception
#     IO.puts("O número: #{n}")
#     while(n + 1)
#   end
# end

# # Testando:
# MathRecursivaWhileAsc.while(9)




# defmodule MathRecursivaWhileRange do
#   def while(ini, fim) when not is_integer(ini) or not is_integer(fim) do
#     IO.puts("Parametros inválidos, precisa passar somente inteiros")
#   end

#   def while(ini, fim) when ini == fim, do: IO.puts("O número: #{ini} de #{fim}")

#   def while(ini, fim) when ini <= fim do
#     IO.puts("O número: #{ini} de #{fim}")
#     while(ini + 1, fim)
#   end
# end

# # Testando:
# MathRecursivaWhileRange.while(1, 100)




# defmodule MathRecursivaFatorial do
#   def factorial(0), do: 1
#   def factorial(n) when n > 0 do
#     n * factorial(n - 1)
#   end
# end

# # Testando:
# IO.puts MathRecursivaFatorial.factorial(5)  # Saída: 120


### 4. Função com Pattern Matching ###

# defmodule Greeting do
#   def hello(:english), do: "Hello!"
#   def hello(:portuguese), do: "Olá!"
#   def hello(:spanish), do: "¡Hola!"
# end



# defmodule Greeting do
#   def hello(:english) do
#     "Hello!"
#   end

#   def hello(:portuguese), do: "Olá!"
#   def hello(:spanish), do: "¡Hola!"
# end

# # Testando:
# IO.puts Greeting.hello(:english)    # Saída: "Hello!"
# IO.puts Greeting.hello(:portuguese) # Saída: "Olá!"
# # IO.puts Greeting.hello(:italian) # Saída: (FunctionClauseError) no function clause matching in Greeting.hello/1



# #### Funções com Parâmetros Opcionais ####
# defmodule Greeting do
#   def greet(name \\ "Amigo") do
#     "Olá, " <> name <> "!" # concatenação 1
#     # "Olá, #{name}!" # concatenação 2
#   end
# end

# # Testando:
# IO.puts Greeting.greet("Danilo")  # Saída: "Olá, Danilo!"
# IO.puts Greeting.greet()          # Saída: "Olá, Amigo!"



# #### Funções Anônimas ####
# multiply = fn (a, b) -> a * b end

# # Testando:
# IO.puts multiply.(2, 3)  # Saída: 6


#### Funções Privadas ####
defmodule Secret do
  def public_function do
    "Resultado público: " <> private_function()
  end

  defp private_function do
    "Segredo!"
  end
end

# Testando:
IO.puts Secret.public_function()  # Saída: "Resultado público: Segredo!"
# IO.puts Secret.private_function()  # Saída: UndefinedFunctionError) function Secret.private_function/0 is undefined or private
