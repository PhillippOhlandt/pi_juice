defimpl PiJuice.Adapter.Interface.Battery, for: PiJuice.Adapter.VirtualBoard do
  alias PiJuice.Board
  alias PiJuice.Adapter.VirtualBoard

  def get_charge_level(%VirtualBoard{name: name}, _opts) do
    adapter_name = Board.process_names(name)[:adapter]
    state_process = VirtualBoard.process_names(adapter_name)[:state]

    with {:ok, charge_level} <-
           VirtualBoard.State.get_data(state_process, [:battery, :charge_level]) do
      {:ok, charge_level}
    end
  end
end
