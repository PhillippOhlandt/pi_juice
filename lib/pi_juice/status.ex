defmodule PiJuice.Status do
  alias PiJuice.Board
  alias PiJuice.Adapter.Interface

  def get_charge_level(name) do
    with {:ok, identifier} <- Board.get_identifier(name) do
      Interface.Status.get_charge_level(identifier)
    end
  end
end
