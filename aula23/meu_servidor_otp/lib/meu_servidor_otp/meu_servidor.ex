defmodule MeuServidor do
  use GenServer

  # Callbacks

  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end

  @impl true
  def handle_call(:obter_estado, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:atualizar_estado, novo_estado}, _state) do
    {:noreply, novo_estado}
  end

  # API Pública

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def obter_estado do
    GenServer.call(__MODULE__, :obter_estado)
  end

  def atualizar_estado(novo_estado) do
    GenServer.cast(__MODULE__, {:atualizar_estado, novo_estado})
  end
end
