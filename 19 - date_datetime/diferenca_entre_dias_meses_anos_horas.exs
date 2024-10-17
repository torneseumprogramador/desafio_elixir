Mix.install([{:timex, "~> 3.7"}])

date1 = ~D[2023-10-09]
date2 = ~D[2024-10-09]

# Diferença em dias
dias_diferenca = Date.diff(date2, date1)
IO.puts("Diferença em dias: #{dias_diferenca}")





date1 = ~D[2023-10-09]
date2 = ~D[2024-10-09]

# Usando Timex para calcular diferença em anos e meses
anos_diferenca = Timex.diff(date2, date1, :years)
meses_diferenca = Timex.diff(date2, date1, :months)

IO.puts("Diferença em anos: #{anos_diferenca}")
IO.puts("Diferença em meses: #{meses_diferenca}")





naive_datetime1 = ~N[2023-10-09 10:00:00]
naive_datetime2 = ~N[2024-10-09 12:30:45]

# Diferença em segundos
segundos_diferenca = NaiveDateTime.diff(naive_datetime2, naive_datetime1)

# Convertendo para outras unidades
horas_diferenca = div(segundos_diferenca, 3600)
minutos_diferenca = div(segundos_diferenca, 60)

IO.puts("Diferença em horas: #{horas_diferenca}")
IO.puts("Diferença em minutos: #{minutos_diferenca}")
IO.puts("Diferença em segundos: #{segundos_diferenca}")
