defmodule PiJuice.Board.Config do
  defstruct []

  def new(args \\ []) do
    struct(__MODULE__, args)
  end
end
