### forma mais simples utilizando FOR

# IO.puts("Digite um número:")

# input = IO.gets("") |> String.trim() |> String.to_integer()

# for n <- 1..input do
#   IO.puts(n)
# end


######## referente ao C# #####
# for (int i = 0; i < n; i++) {
#   Console.WriteLine(i);
# }




# ######## referente ao elixir - Comprehensions (for) #####
# n = IO.gets("Digite um número: ") |> String.trim() |> String.to_integer()

# for i <- 0..(n-1) do
#   IO.puts("O valor de i é: #{i}")
# end

# ### for com critério (rem(n, 2) == 0, pega o número par) ###
# for n <- 1..10, rem(n, 2) == 0 do
#   IO.puts("Número par: #{n}")
# end

#### mostra somente do 5 ao 8
# for n <- 1..10, n >= 5 and n <= 8 do
#   IO.puts("Número par: #{n}")
# end






# ###### agora que já entendemos o que é modulo a partir da aula 12, utilizamos recursão para loop
# defmodule MathRecursivaWhileAsc do
#   def while(10), do: IO.puts("O número: 10") # tratamento para que a função possa funcionar se o valor estiver fora do guard
#   def while(n) when n < 10 do # função com guard, caso não seja <= 0 dispara exception
#     IO.puts("O número: #{n}")
#     while(n + 1)
#   end
# end

# # Testando:
# MathRecursivaWhileAsc.while(9)




# #### Loop com each ####
# numeros = [2,3,5,6,8,9]
# Enum.each(numeros, fn numero ->
#   IO.puts("Numero: #{ numero }")
# end)


#### Stream.cycle (Loop Infinito) ####
# stream = Stream.cycle([1, 2, 3, 6]) # crio um ciclo para o critério de finalização do loop
# Enum.take(stream, 10) |> Enum.each(fn x -> IO.puts("Ciclo: #{x}") end)

# # exemplo 2
# stream = Stream.cycle(["Oiiiii"]) # crio um ciclo para o critério de finalização do loop
# Enum.take(stream, 10) |> IO.inspect


#### recursão com cond ###

defmodule ConditionalLoop do
  def run_loop(n) do
    cond do
      n > 0 ->
        IO.puts("Número: #{n}")
        run_loop(n - 1)
      true ->
        IO.puts("Loop finalizado")
    end
  end
end

# Chamando o loop
ConditionalLoop.run_loop(5)
