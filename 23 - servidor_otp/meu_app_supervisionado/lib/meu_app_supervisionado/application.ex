defmodule MeuAppSupervisionado.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: MeuAppSupervisionado.Worker.start_link(arg)
      # {MeuAppSupervisionado.Worker, arg}
      {Registry, keys: :unique, name: :contadores_registry},
      MeuAppSupervisionado.SupervisorDinamico,
      MeuAppSupervisionado.Relogio
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MeuAppSupervisionado.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
