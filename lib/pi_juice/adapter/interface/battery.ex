defprotocol PiJuice.Adapter.Interface.Battery do
  @spec get_charge_level(t, [{:retries, non_neg_integer}]) :: {:ok, integer} | {:error, term}
  def get_charge_level(identifier, opts)
end
