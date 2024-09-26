# Cris é uma empreendedora de sucesso, ela precisa criar um sistema
# para automatizar sua empresa de cosmético e quimica
# para isso vc tem a missão de criar um programa que armazene os produtos
# e seu codigo na tabela periódica
# (não precisa ser um valor real da tabela periódica "pode ser qualquer número")
# regra para o numero da tabela periódica do exercicio:
# de 1 .. 6 categoria 1
# de 7 .. 25 categoria 2
# de 26 .. 29 categoria 3
# de 30 .. 31 categoria 4
# demais categoria 5
# os dados a cadastrar do produto serão:
# id (automático), nome, descricao, codigo_tabela_periodica
# no final do programa vc terá que dar um relatório dos produtos agrupados
# por seu codigo_tabela_periodica.

# de 7 .. 25 categoria 2
# de 26 .. 29 categoria 3
# de 30 .. 31 categoria 4

produtos = []
codigo_produto1 = DateTime.to_unix(DateTime.utc_now())
nome_produto1 = IO.gets("Digite o nome do produto 1\n") |> String.trim()
descricao_produto1 = IO.gets("Digite a descricao do produto 1\n") |> String.trim()
{codigo_tabela_periodica_produto1, _} = IO.gets("Digite o codigo da tabela periódica do produto 1\n") |> String.trim() |> Integer.parse()
produtos = produtos ++ [[codigo_produto1, nome_produto1, descricao_produto1, codigo_tabela_periodica_produto1]]

codigo_produto2 = DateTime.to_unix(DateTime.utc_now())
nome_produto2 = IO.gets("Digite o nome do produto 2\n") |> String.trim()
descricao_produto2 = IO.gets("Digite a descricao do produto 2\n") |> String.trim()
{codigo_tabela_periodica_produto2, _} = IO.gets("Digite o codigo da tabela periódica do produto 2\n") |> String.trim() |> Integer.parse()
produtos = produtos ++ [[codigo_produto2, nome_produto2, descricao_produto2, codigo_tabela_periodica_produto2]]

codigo_produto3 = DateTime.to_unix(DateTime.utc_now())
nome_produto3 = IO.gets("Digite o nome do produto 3\n") |> String.trim()
descricao_produto3 = IO.gets("Digite a descricao do produto 3\n") |> String.trim()
{codigo_tabela_periodica_produto3, _} = IO.gets("Digite o codigo da tabela periódica do produto 3\n") |> String.trim() |> Integer.parse()
produtos = produtos ++ [[codigo_produto3, nome_produto3, descricao_produto3, codigo_tabela_periodica_produto3]]

# nome_produto1 = "Parabeno"
# descricao_produto1 = "Produto quimico que ajuda a alisar o cabelo"
# codigo_tabela_periodica_produto1 = 22
# codigo_produto1 = DateTime.to_unix(DateTime.utc_now())
# produtos = produtos ++ [[codigo_produto1, nome_produto1, descricao_produto1, codigo_tabela_periodica_produto1]]

# nome_produto1 = "Oleo de rosas"
# descricao_produto1 = "Para deixar o cabelo mais macio"
# codigo_tabela_periodica_produto1 = 23
# codigo_produto1 = DateTime.to_unix(DateTime.utc_now())
# produtos = produtos ++ [[codigo_produto1, nome_produto1, descricao_produto1, codigo_tabela_periodica_produto1]]
# IO.inspect(produtos)

categoria1 = 1..6
categoria2 = 7..25
categoria3 = 26..29
categoria4 = 30..31
# categoria5 = n > 31

lista_categoria1 = Enum.filter(produtos, fn p -> Enum.at(p, 3) in categoria1 end)
lista_categoria2 = Enum.filter(produtos, fn p -> Enum.at(p, 3) in categoria2 end)
lista_categoria3 = Enum.filter(produtos, fn p -> Enum.at(p, 3) in categoria3 end)
lista_categoria4 = Enum.filter(produtos, fn p -> Enum.at(p, 3) in categoria4 end)
lista_categoria5 = Enum.filter(produtos, fn p -> Enum.at(p, 3) > 31 end)

IO.puts("======= Lista de produtos da categoria 1 =====")
if Enum.count(lista_categoria1) > 0 do
  Enum.each(lista_categoria1, fn produto ->
    IO.puts("Codigo: #{ Enum.at(produto, 0) }")
    IO.puts("Nome: #{ Enum.at(produto, 1) }")
    IO.puts("Descrição: #{ Enum.at(produto, 2) }")
    IO.puts("Codigo da tabela periódica: #{ Enum.at(produto, 3) }")
  end)
else
  IO.puts("Não existem produtos")
end
IO.puts("================================")

IO.puts("======= Lista de produtos da categoria 2 =====")
if Enum.count(lista_categoria2) > 0 do
  Enum.each(lista_categoria2, fn produto ->
    IO.puts("Codigo: #{ Enum.at(produto, 0) }")
    IO.puts("Nome: #{ Enum.at(produto, 1) }")
    IO.puts("Descrição: #{ Enum.at(produto, 2) }")
    IO.puts("Codigo da tabela periódica: #{ Enum.at(produto, 3) }")
    IO.puts("\n\n\n")
  end)
else
  IO.puts("Não existem produtos")
end
IO.puts("================================")

IO.puts("======= Lista de produtos da categoria 3 =====")
if Enum.count(lista_categoria3) > 0 do
  Enum.each(lista_categoria3, fn produto ->
    IO.puts("Codigo: #{ Enum.at(produto, 0) }")
    IO.puts("Nome: #{ Enum.at(produto, 1) }")
    IO.puts("Descrição: #{ Enum.at(produto, 2) }")
    IO.puts("Codigo da tabela periódica: #{ Enum.at(produto, 3) }")
    IO.puts("\n\n\n")
  end)
else
  IO.puts("Não existem produtos")
end
IO.puts("================================")

IO.puts("======= Lista de produtos da categoria 4 =====")
if Enum.count(lista_categoria4) > 0 do
  Enum.each(lista_categoria4, fn produto ->
    IO.puts("Codigo: #{ Enum.at(produto, 0) }")
    IO.puts("Nome: #{ Enum.at(produto, 1) }")
    IO.puts("Descrição: #{ Enum.at(produto, 2) }")
    IO.puts("Codigo da tabela periódica: #{ Enum.at(produto, 3) }")
    IO.puts("\n\n\n")
  end)
else
  IO.puts("Não existem produtos")
end
IO.puts("================================")

IO.puts("======= Lista de produtos da categoria 5 =====")
if Enum.count(lista_categoria5) > 0 do
  Enum.each(lista_categoria5, fn produto ->
    IO.puts("Codigo: #{ Enum.at(produto, 0) }")
    IO.puts("Nome: #{ Enum.at(produto, 1) }")
    IO.puts("Descrição: #{ Enum.at(produto, 2) }")
    IO.puts("Codigo da tabela periódica: #{ Enum.at(produto, 3) }")
    IO.puts("\n\n\n")
  end)
else
  IO.puts("Não existem produtos")
end
IO.puts("================================")
