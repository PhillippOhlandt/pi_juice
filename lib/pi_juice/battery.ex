defmodule PiJuice.Battery do
  alias PiJuice.Board
  alias PiJuice.Adapter.Interface

  @type name :: atom

  @spec get_charge_level(name, [{:retries, non_neg_integer}]) :: {:ok, integer} | {:error, term}
  def get_charge_level(name, opts \\ []) do
    with {:ok, identifier} <- Board.get_identifier(name) do
      Interface.Battery.get_charge_level(identifier, opts)
    end
  end
end
