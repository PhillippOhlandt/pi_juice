defmodule PiJuice.Board.Manager do
  use GenServer

  def start_link(opts) do
    name = Keyword.get(opts, :name) || raise ArgumentError, "A name must be supplied"

    GenServer.start_link(__MODULE__, opts, name: name)
  end

  @impl true
  def init(_opts) do
    state = %{}

    {:ok, state}
  end
end
