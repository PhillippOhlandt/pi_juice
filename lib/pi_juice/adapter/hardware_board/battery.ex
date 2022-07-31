defimpl PiJuice.Adapter.Interface.Battery, for: PiJuice.Adapter.HardwareBoard do
  alias PiJuice.Board
  alias PiJuice.Adapter.HardwareBoard

  @charge_level_register 0x41

  def get_charge_level(%HardwareBoard{name: name}, opts) do
    adapter_name = Board.process_names(name)[:adapter]
    comm_process = HardwareBoard.process_names(adapter_name)[:communication]

    result = HardwareBoard.Communication.read(comm_process, @charge_level_register, 1, opts)

    with {:ok, <<charge_level>>} <- result do
      {:ok, charge_level}
    end
  end
end
