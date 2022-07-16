defmodule PiJuice.Adapter do
  @callback identifier(atom) :: struct

  @callback child_spec(term) :: Supervisor.child_spec()

  @callback new_config() :: struct
  @callback new_config(Enum.t()) :: struct
end
