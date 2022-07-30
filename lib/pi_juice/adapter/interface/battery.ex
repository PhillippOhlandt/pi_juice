defprotocol PiJuice.Adapter.Interface.Battery do
  @spec get_charge_level(t) :: {:ok, integer} | {:error, term}
  def get_charge_level(identifier)
end
