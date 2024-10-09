defmodule DatetimeTest do
  use Application

  def start(_type, _args) do
    # Criação de uma data e hora com fuso horário UTC
    datetime = DateTime.utc_now() # hora brasilia +  3 horas
    IO.inspect(datetime)

    # Conversão para outro fuso horário
    {:ok, datetime_brasilia} = DateTime.shift_zone(datetime, "America/Sao_Paulo")
    IO.inspect(datetime_brasilia)

    {:ok, self()}
  end
end
