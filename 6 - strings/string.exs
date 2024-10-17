nome = "Danilo"
mensagem = "Olá, #{nome}!" # string mais fácil para utilização de funções de tratamento
# mensagem = 'Olá, #{nome}!' # list de unicode, precisa converter para utilizar tratamento de strings

IO.puts(mensagem)

mensagem = String.upcase(mensagem) # transforma para maiúsculo
IO.puts(mensagem)

mensagem = String.downcase(mensagem) # transforma para minusculo
IO.puts(mensagem)

dados = String.split(mensagem, ",") # transforma string em um array dividido por ","
IO.inspect(dados) # inspecionar variável

slice1 = String.slice("Elixir", 1, 3)  # "lix" # serve para capturar informação "de para" dentro de uma string
IO.puts(slice1)

slice2 = String.slice("Elixir", 2..5) # "ir" # tambem podemos utilizar o range para buscar informação em uma string
IO.puts(slice2)

verdadeiro = Regex.match?(~r/elixir/, "elixir é incrível")  # para trabalhar com regular expression
IO.puts(verdadeiro)

mensagem_com_ceps = "A prática cotidiana prova que o acompanhamento das preferências de consumo 000903-340 nos obriga à análise das diversas 653356-897 correntes de pensamento."

verdadeiro = Regex.match?(~r/\d{6}-\d{3}/, mensagem_com_ceps)  # verificando se existe um cep no texto
IO.puts(verdadeiro) # true pois existe cep no texto

dado = Regex.run(~r/\d{6}-\d{3}/, mensagem_com_ceps)
IO.inspect(dado) # mostra o primeiro cep capturado

dados = Regex.scan(~r/\d{6}-\d{3}/, mensagem_com_ceps)
IO.inspect(dados) # mostra a lista de cep capturado

IO.puts("-----------")
IO.puts(mensagem_com_ceps)
IO.puts("-----------")
mensagem = Regex.replace(~r/\d{6}-\d{3}/, mensagem_com_ceps, "(CEP ESCONDIDO)")
IO.puts(mensagem) # substitui todos os ceps por CEP ESCONDIDO
IO.puts("-----------")


IO.puts(String.length(mensagem))  # quantidade de caractes que tem em uma string


resultado = String.contains?(mensagem, "(CEP ESCONDIDO)")  # verifica se existe uma informação dentro de um texto

IO.puts(resultado)

IO.puts(String.length(to_string('teste'))) # lista de unicode convertida para string e depois contando os caracteres

IO.puts(String.length("Chalé")) # conta com caractes em acento normal

IO.puts(String.replace("Elixir", "i", "1"))  # "El1x1r" # classico replace de strings
