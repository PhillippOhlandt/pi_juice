defmodule PiJuice.Adapter.HardwareBoard.Config do
  @behaviour PiJuice.Adapter.Config

  defstruct address: 0x14, bus_name: nil

  @impl true
  def new(args \\ []) do
    struct(__MODULE__, args)
  end
end
