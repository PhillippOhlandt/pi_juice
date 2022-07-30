defmodule PiJuice.Battery do
  alias PiJuice.Board
  alias PiJuice.Adapter.Interface

  # TODO: add options parameter
  def get_charge_level(name) do
    with {:ok, identifier} <- Board.get_identifier(name) do
      Interface.Battery.get_charge_level(identifier)
    end
  end
end
