defmodule PiJuice.Adapter.HardwareBoard do
  @behaviour PiJuice.Adapter

  use Supervisor

  alias PiJuice.Adapter.HardwareBoard

  defstruct [:name]

  def start_link(opts) do
    name = Keyword.get(opts, :name) || raise ArgumentError, "A name must be supplied"
    board_name = Keyword.get(opts, :board_name, board_name_from_name(name)) # todo: maybe remove it if not needed
    config = HardwareBoard.Config.new(Keyword.get(opts, :config, []))

    state = %{
      name: name,
      board_name: board_name,
      config: config
    }

    Supervisor.start_link(__MODULE__, state, name: process_names(name)[:supervisor])
  end

  @impl Supervisor
  def init(state) do
    children = [
      {HardwareBoard.State, [name: process_names(state.name)[:state], state: state]},
      {HardwareBoard.Communication, [name: process_names(state.name)[:communication], adapter_name: state.name]},
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end

  @impl PiJuice.Adapter
  def child_spec(opts) do
    name = Keyword.get(opts, :name) || raise ArgumentError, "An adapter name must be supplied"

    %{
      id: process_names(name)[:supervisor],
      start: {__MODULE__, :start_link, [opts]},
      type: :supervisor
    }
  end

  @impl PiJuice.Adapter
  def identifier(name) do
    %__MODULE__{name: name}
  end

  @impl PiJuice.Adapter
  def new_config(args \\ []) do
    HardwareBoard.Config.new(args)
  end

  def process_names(name) do
    %{
      supervisor: Module.concat([name, Supervisor]),
      state: Module.concat([name, State]),
      communication: Module.concat([name, Communication])
    }
  end

  defp board_name_from_name(name) do
    name
    |> Module.split()
    |> Enum.drop(-1)
    |> Module.concat()
  end
end
