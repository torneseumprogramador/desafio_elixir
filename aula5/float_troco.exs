# João é um empreendedor e precisa de um software
# para ajudar a calcular o troco sobre a venda de um produto
# sua missão é criar um programa que solicite o:
# Nome do cliente
# Nome do produto
# Valor do produto
# Seu pagamento

# O resultado terá que ser:
# O troco para o usuário <NOME> na compra do produto <PRODUTO>
# no valor de <VALOR> com o total de pagamento <PAGAMENTO> é de <TROCO>

# valor  = Float.parse("10")

nome = IO.gets("Digite o nome do cliente\n") |> String.trim()
produto = IO.gets("Digite o nome do produto\n") |> String.trim()
{valor, _} = IO.gets("Digite o valor do produto (formato: 0.0) \n") |> String.trim() |> Float.parse()
{pagamento, _} = IO.gets("Digite o valor do pagamento do(a) #{nome} (formato: 0.0)\n") |> String.trim() |> Float.parse()

# require IEx; IEx.pry() # debugger

troco = pagamento - valor

valor_formatado = :io_lib.format("~.2f", [valor]) |> List.to_string()
pagamento_formatado = :io_lib.format("~.2f", [pagamento]) |> List.to_string()
troco_formatado = :io_lib.format("~.2f", [troco]) |> List.to_string()

IO.puts("
O troco para o usuário #{nome} na compra do produto #{produto}
no valor de R$#{valor_formatado} com o total de pagamento R$#{pagamento_formatado} é de: R$#{troco_formatado}
")
