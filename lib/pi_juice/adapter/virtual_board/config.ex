defmodule PiJuice.Adapter.VirtualBoard.Config do
  @behaviour PiJuice.Adapter.Config

  defstruct address: 0x14

  @impl true
  def new(args \\ []) do
    struct(__MODULE__, args)
  end
end
