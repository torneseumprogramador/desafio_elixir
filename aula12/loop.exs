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

######## referente ao elixir# #####
n = IO.gets("Digite um número: ") |> String.trim() |> String.to_integer()

for i <- 0..(n-1) do
  IO.puts("O valor de i é: #{i}")
end
