defmodule PiJuice.Adapter.HardwareBoard.Communication do
  use GenServer
  use Bitwise

  alias Circuits.I2C
  alias PiJuice.Adapter.HardwareBoard

  def start_link(opts) do
    name = Keyword.get(opts, :name) || raise ArgumentError, "A name must be supplied"

    adapter_name =
      Keyword.get(opts, :adapter_name) || raise ArgumentError, "An adapter_name must be supplied"

    state = %{
      adapter_name: adapter_name
    }

    GenServer.start_link(__MODULE__, state, name: name)
  end

  def read(name, register, length, opts \\ []) do
    with {:ok, pid} <- get_process(name) do
      GenServer.call(pid, {:read, register, length, opts})
    end
  end

  @impl true
  def init(state) do
    state_process = HardwareBoard.process_names(state.adapter_name)[:state]

    {:ok, config} = HardwareBoard.State.get_config(state_process)

    # todo: maybe handle error case
    {i2c_ref, config} = establish_connection(config)

    state =
      state
      |> Map.put(:i2c_ref, i2c_ref)
      |> Map.put(:address, config.address)

    HardwareBoard.State.set_config(state_process, config)

    {:ok, state}
  end

  @impl true
  def handle_call({:read, register, length, opts}, _from, state) do
    retries = Keyword.get(opts, :retries, 0)

    result =
      I2C.write_read(
        state.i2c_ref,
        state.address,
        <<register>>,
        length + 1,
        retries: retries
      )

    reply =
      case result do
        {:ok, <<result_data::binary-size(length), checksum::integer>>} ->
          case get_checksum(result_data) == checksum do
            true ->
              {:ok, result_data}

            false ->
              rest_length = length - 1
              <<first_byte::binary-size(1), rest::binary-size(rest_length)>> = result_data

              new_data = <<bor(first_byte, 0x80), rest::binary>>

              case get_checksum(new_data) == checksum do
                true -> {:ok, new_data}
                false -> {:error, :corrupted_data}
              end
          end

        error ->
          error
      end

    {:reply, reply, state}
  end

  def get_checksum(data) when is_integer(data) do
    get_checksum(<<data>>)
  end

  def get_checksum(data) when is_binary(data) do
    for <<value::size(8) <- data>>, reduce: 0xFF do
      acc -> bxor(acc, value)
    end
  end

  defp establish_connection(%HardwareBoard.Config{address: address, bus_name: nil} = config) do
    {bus_name, _address} = I2C.discover_one!([address])

    new_config = %HardwareBoard.Config{config | bus_name: bus_name}

    establish_connection(new_config)
  end

  defp establish_connection(%HardwareBoard.Config{address: _address, bus_name: bus_name} = config) do
    {:ok, i2c_ref} = I2C.open(bus_name)

    {i2c_ref, config}
  end

  defp get_process(name) do
    case GenServer.whereis(name) do
      nil -> {:error, :not_found}
      pid -> {:ok, pid}
    end
  end
end
