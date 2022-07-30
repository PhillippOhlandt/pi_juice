defmodule PiJuice.Adapter.VirtualBoard.State do
  use GenServer

  require PiJuice.Adapter.VirtualBoard.Config

  alias PiJuice.Adapter.VirtualBoard

  @default %{
    name: nil,
    board_name: nil,
    config: VirtualBoard.Config.new(),
    data: %{
      battery: %{
        charge_level: 50
      }
    }
  }

  def start_link(opts) do
    name = Keyword.get(opts, :name) || raise ArgumentError, "A name must be supplied"
    state = Keyword.get(opts, :state, %{})

    GenServer.start_link(__MODULE__, state, name: name)
  end

  def get_name(name) do
    get_by_key(name, :name)
  end

  def get_board_name(name) do
    get_by_key(name, :board_name)
  end

  def get_config(name) do
    get_by_key(name, :config)
  end

  def get_data(name) do
    get_by_key(name, :data)
  end

  def get_data(name, keys) when is_list(keys) and length(keys) > 0 do
    with {:ok, data} <- get_by_key(name, :data),
         value <- get_in(data, keys) do
      case value do
        nil -> {:error, :not_found}
        value -> {:ok, value}
      end
    end
  end

  def set_config(name, %VirtualBoard.Config{} = config) do
    with {:ok, pid} <- get_process(name) do
      GenServer.call(pid, {:set_config, config})
    end
  end

  @impl true
  def init(state) do
    ets_table =
      :ets.new(VirtualBoard.process_names(state.name)[:state], [
        :set,
        :protected,
        :named_table,
        {:read_concurrency, true}
      ])

    state = Enum.into(state, @default)

    for item <- state do
      :ets.insert(ets_table, item)
    end

    state = %{
      subscribers: [],
      ets_table: ets_table
    }

    {:ok, state}
  end

  @impl true
  def handle_call({:set_config, config}, _from, state) do
    :ets.insert(state.ets_table, {:config, config})

    {:reply, :ok, state}
  end

  @impl true
  def handle_call(_msg, _from, state) do
    {:reply, {:error, :unknown_message}, state}
  end

  @impl true
  def handle_cast(_msg, state) do
    {:noreply, state}
  end

  defp get_by_key(name, key) do
    with {:ok, ref} <- get_table(name) do
      case :ets.lookup(ref, key) do
        [{^key, value}] -> {:ok, value}
        [] -> {:error, :not_found}
      end
    end
  end

  defp get_table(name) do
    case :ets.whereis(name) do
      nil -> {:error, :not_found}
      :undefined -> {:error, :not_found}
      ref -> {:ok, ref}
    end
  end

  defp get_process(name) do
    case GenServer.whereis(name) do
      nil -> {:error, :not_found}
      pid -> {:ok, pid}
    end
  end
end
