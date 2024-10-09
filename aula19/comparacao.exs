# Criação de duas datas
date1 = ~D[2023-10-09]
date2 = ~D[2024-10-09]

IO.puts("=== Comparação de datas com if ===")
if Date.compare(date1, date2) == :lt do
  IO.puts("date1 é menor que date2")
else
  IO.puts("date1 não é menor que date2")
end


IO.puts("=== Comparando datas com case ===")
case Date.compare(date1, date2) do
  :lt -> IO.puts("date1 é menor que date2")
  :eq -> IO.puts("As datas são iguais")
  :gt -> IO.puts("date1 é maior que date2")
end

IO.puts("=== Comparando datas com cond ===")
cond do
  Date.compare(date1, date2) == :lt -> IO.puts("date1 é menor que date2")
  Date.compare(date1, date2) == :eq -> IO.puts("As datas são iguais")
  Date.compare(date1, date2) == :gt -> IO.puts("date1 é maior que date2")
end

IO.puts("=== Comparando com NaiveDateTime ===")
naive_datetime1 = ~N[2024-10-09 14:30:00]
naive_datetime2 = ~N[2023-10-09 14:30:00]
if NaiveDateTime.compare(naive_datetime1, naive_datetime2) == :gt do
  IO.puts("naive_datetime1 é maior que naive_datetime2")
end
