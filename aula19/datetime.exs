Mix.install([{:tzdata, "~> 1.0"}, {:timex, "~> 3.7"}])
Application.put_env(:elixir, :time_zone_database, Tzdata.TimeZoneDatabase)

# Criação de uma data e hora com fuso horário UTC
datetime = DateTime.utc_now() # hora brasilia +  3 horas
IO.inspect(datetime)

# Conversão para outro fuso horário
{:ok, datetime_brasilia} = DateTime.shift_zone(datetime, "America/Sao_Paulo")
IO.inspect(datetime_brasilia)


# Criação de uma data e hora sem fuso horário
naive_datetime = ~N[2024-10-09 14:30:00]
IO.inspect(naive_datetime)

# Operações com NaiveDateTime
later_naive_datetime = NaiveDateTime.add(naive_datetime, 3600) # adicionando 1 hora na data
IO.inspect(later_naive_datetime)


IO.puts("========= Data + 1 dia ==========")
naive_datetime = ~N[2024-10-09 14:30:00]
IO.inspect(naive_datetime)

# Adicionando 1 dia
data_mais_um_dia = NaiveDateTime.add(naive_datetime, 1, :day) # (:day, :hour, :minute, :second, :millisecond, :microsecond, :nanosecond, or a positive integer)
IO.inspect(data_mais_um_dia)
IO.puts("================================")

IO.puts("========= Data + 30 dias ==========")
naive_datetime = ~N[2024-10-09 14:30:00]
IO.inspect(naive_datetime)

# Extraindo a data e hora do NaiveDateTime
date = NaiveDateTime.to_date(naive_datetime)
time = NaiveDateTime.to_time(naive_datetime)

# Adicionando 1 mês à data
new_date = Date.add(date, 30) # Adicionando 30 dias (aproximadamente 1 mês)
new_naive_datetime = NaiveDateTime.new!(new_date, time)

IO.inspect(new_naive_datetime)
IO.puts("================================")


IO.puts("========= Data + 1 mes ==========")

defmodule DateMonth do
  def exec() do
    # Criação de uma data e hora
    naive_datetime = ~N[2024-10-09 14:30:00]
    IO.inspect(naive_datetime)

    #### Na versão do Elixir 1.17 existe a função abaixo no DateTime ###
    # DateTime.shift(DateTime.utc_now(), month: 1)

    # Adicionando 1 mês usando Timex
    new_naive_datetime = Timex.shift(naive_datetime, months: 1)
    IO.inspect(new_naive_datetime)
  end
end

DateMonth.exec()

IO.puts("================================")



IO.puts("========= Data + 1 ano ==========")

defmodule DateYear do
  def exec() do
    # Criação de uma data e hora
    naive_datetime = ~N[2024-10-09 14:30:00]
    IO.inspect(naive_datetime)

    #### Na versão do Elixir 1.17 existe a função abaixo no DateTime ###
    # DateTime.shift(DateTime.utc_now(), year: 1)

    # Adicionando1 ano usando Timex
    data_com_mais_um_ano = Timex.shift(naive_datetime, years: 1)
    IO.inspect(data_com_mais_um_ano)
  end
end

DateYear.exec()

IO.puts("================================")
