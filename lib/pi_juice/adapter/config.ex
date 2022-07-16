defmodule PiJuice.Adapter.Config do
  @callback new() :: struct
  @callback new(Enum.t()) :: struct
end
