# Criação de uma data
data = ~D[2024-10-09]
IO.inspect(data)

# Operações com datas
amanha = Date.add(data, 1)
IO.inspect(amanha)
# Comparação de datas
IO.inspect(Date.compare(data, amanha)) # :lt (less than) data < amanha

# Operações com datas
ontem = Date.add(data, -1)
IO.inspect(ontem)
# Comparação de datas
IO.inspect(Date.compare(data, ontem)) # :gt (greater than) dat > ontem

IO.inspect(Date.compare(data, data)) # :eq (equal) data = data
