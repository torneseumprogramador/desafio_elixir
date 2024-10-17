defmodule ConsoleApp do
  use Application

  def start(_type, _args) do
    hello() # pega parametros externos
    {:ok, self()}
  end

  @moduledoc """
  Documentation for `ConsoleApp`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ConsoleApp.hello()
      :world

  """
  def hello do
    mensagem = LibAulaMix.mensagem("Danilo")
    IO.puts(mensagem)
  end
end
