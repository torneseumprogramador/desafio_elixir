defmodule MeuAppSupervisionado.Relogio do
  use GenServer

  # API Pública

  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def obter_hora do
    GenServer.call(__MODULE__, :obter_hora)
  end

  def falhar do
    GenServer.cast(__MODULE__, :falhar)
  end

  # Callbacks

  @impl true
  def handle_cast(:falhar, state) do
    {:noreply, %{state | should_fail: true}}
  end

  @impl true
  def handle_info(:tick, %{should_fail: true} = state) do
    raise "Falha intencional no Relogio"
  end


  @impl true
  def init(state) do
    schedule_tick()
    # {:ok, state}
    {:ok, %{should_fail: false}}
  end


  @impl true
  def handle_info(:tick, state) do
    IO.puts("Hora atual: #{DateTime.utc_now()}")
    schedule_tick()
    {:noreply, state}
  end

  defp schedule_tick do
    Process.send_after(self(), :tick, 1000)  # A cada 1 segundo
  end

  @impl true
  def handle_call(:obter_hora, _from, state) do
    {:reply, DateTime.utc_now(), state}
  end
end
