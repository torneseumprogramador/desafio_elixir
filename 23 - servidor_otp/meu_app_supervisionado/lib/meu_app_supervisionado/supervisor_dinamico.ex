defmodule MeuAppSupervisionado.SupervisorDinamico do
  use DynamicSupervisor

  def start_link(_args) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_contador(name, initial_count) do
    spec = %{
      id: {:contador, name},
      start: {MeuAppSupervisionado.Contador, :start_link, [name, initial_count]},
      restart: :permanent,
      shutdown: 5000,
      type: :worker
    }

    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end
