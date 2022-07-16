defmodule PiJuice.Adapter.VirtualBoard do
  @behaviour PiJuice.Adapter

  use Supervisor

  alias PiJuice.Adapter.VirtualBoard

  defstruct [:name]

  def start_link(opts) do
    name = Keyword.get(opts, :name) || raise ArgumentError, "A name must be supplied"
    # todo: maybe remove it if not needed
    board_name = Keyword.get(opts, :board_name, board_name_from_name(name))
    config = VirtualBoard.Config.new(Keyword.get(opts, :config, []))

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
      {VirtualBoard.State, [name: process_names(state.name)[:state], state: state]}
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
    VirtualBoard.Config.new(args)
  end

  def process_names(name) do
    %{
      supervisor: Module.concat([name, Supervisor]),
      state: Module.concat([name, State])
    }
  end

  defp board_name_from_name(name) do
    name
    |> Module.split()
    |> Enum.drop(-1)
    |> Module.concat()
  end
end
