defmodule Fogetes do
  use Application
  alias UI.Menu

  def start(_type, _args) do
    init(System.argv()) # pega parametros externos
    {:ok, self()}
  end

  def init(args) do
    env = System.get_env("ENV")
    IO.puts("O programa foi iniciado")
    IO.inspect(args, label: "Argumentos recebidos")
    IO.inspect(env, label: "Argumento recebido por variável de ambiente ENV")

    ### Inicia o programa ###
    Menu.init()
  end
end
