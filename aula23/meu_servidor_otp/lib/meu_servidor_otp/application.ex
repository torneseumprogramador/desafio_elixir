defmodule MeuServidorOtp.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {MeuServidor, :estado_inicial}
    ]

    opts = [strategy: :one_for_one, name: MeuServidorOtp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
