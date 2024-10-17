# Criação de um horário
time = ~T[14:30:00]
IO.inspect(time)

# Operações com horários
time_menos_uma_hora = Time.add(time, -3600) # -3600 referente a 60 minutos
IO.inspect(time_menos_uma_hora) # time com 1 hora a menos
# Comparação de horários
IO.inspect(Time.compare(time, time_menos_uma_hora)) # :gt (greater than) time > time_menos_uma_hora


# Operações com datas
time_mais_uma_hora = Time.add(time, 3600)
IO.inspect(time_mais_uma_hora)
# Comparação de datas
IO.inspect(Time.compare(time, time_mais_uma_hora)) # :lt (less than) time < time_mais_uma_hora

IO.inspect(Time.compare(time, time)) # :eq (equal) time = time
