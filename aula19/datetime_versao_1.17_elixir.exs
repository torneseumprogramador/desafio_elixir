#### Na versão do Elixir 1.17 existe a função abaixo no DateTime ###

data_agora = DateTime.utc_now()
IO.inspect(data_agora)

um_dia = DateTime.shift(data_agora, day: 1) # acrescenta 1 dia
IO.inspect(um_dia)

um_mes = DateTime.shift(data_agora, month: 1) # acrescenta 1 mes
IO.inspect(um_mes)

um_ano = DateTime.shift(data_agora, year: 1) # acrescenta 1 ano
IO.inspect(um_ano)
