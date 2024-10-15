defmodule MeuAppSupervisionado.Contador do
  use GenServer

  # API Pública

  def start_link(name, initial_count) do
    GenServer.start_link(__MODULE__, initial_count, name: via_tuple(name))
  end

  def incrementar(name) do
    GenServer.cast(via_tuple(name), :incrementar)
  end

  def obter_contagem(name) do
    GenServer.call(via_tuple(name), :obter_contagem)
  end

  def falhar(name) do
    GenServer.cast(via_tuple(name), :falhar)
  end

  defp via_tuple(name) do
    {:via, Registry, {:contadores_registry, name}}
  end

  # Callbacks

  @impl true
  def init(initial_count) do
    {:ok, initial_count}
  end

  @impl true
  def handle_cast(:incrementar, count) do
    {:noreply, count + 1}
  end

  @impl true
  def handle_cast(:falhar, _count) do
    raise "Falha intencional no Contador #{inspect(self())}"
  end

  @impl true
  def handle_call(:obter_contagem, _from, count) do
    {:reply, count, count}
  end
end
