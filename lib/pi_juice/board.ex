defmodule PiJuice.Board do
  use Supervisor

  alias PiJuice.Board

  def start_link(opts) do
    name = Keyword.get(opts, :name) || raise ArgumentError, "A name must be supplied"
    adapter = Keyword.get(opts, :adapter, PiJuice.Adapter.HardwareBoard)
    config = Board.Config.new(Keyword.get(opts, :config, []))
    adapter_config = Keyword.get(opts, :adapter_config, [])

    state = %{
      name: name,
      adapter: adapter,
      config: config,
      adapter_config: adapter_config
    }

    Supervisor.start_link(__MODULE__, state, name: process_names(name)[:supervisor])
  end

  @impl true
  def init(state) do
    clean_state = Map.delete(state, :adapter_config)

    children = [
      {Board.State, [name: process_names(state.name)[:state], state: clean_state]},
      {Board.Manager, [name: process_names(state.name)[:manager]]},
      {state.adapter,
       [
         name: process_names(state.name)[:adapter],
         board_name: state.name,
         config: state.adapter_config
       ]}
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end

  def child_spec(opts) do
    name = Keyword.get(opts, :name) || raise ArgumentError, "A board name must be supplied"

    %{
      id: process_names(name)[:supervisor],
      start: {__MODULE__, :start_link, [opts]},
      type: :supervisor
    }
  end

  def running?(name) do
    case check_running(name) do
      :ok -> true
      _ -> false
    end
  end

  def get_identifier(name) do
    with {:ok, adapter} <- get_adapter(name) do
      {:ok, adapter.identifier(name)}
    end
  end

  def get_adapter(name) do
    with :ok <- check_running(name) do
      Board.State.get_adapter(process_names(name)[:state])
    end
  end

  def get_config(name) do
    with :ok <- check_running(name) do
      Board.State.get_config(process_names(name)[:state])
    end
  end

  def get_adapter_config(_name) do
    # todo: implement
  end

  def set_config(name, %Board.Config{} = config) do
    with :ok <- check_running(name) do
      Board.State.set_config(process_names(name)[:state], config)
    end
  end

  def process_names(name) do
    %{
      supervisor: Module.concat([name, Supervisor]),
      state: Module.concat([name, State]),
      manager: name,
      adapter: Module.concat([name, Adapter])
    }
  end

  defp check_running(name) do
    case Process.whereis(process_names(name)[:manager]) do
      nil -> {:error, :not_found}
      _ -> :ok
    end
  end
end
