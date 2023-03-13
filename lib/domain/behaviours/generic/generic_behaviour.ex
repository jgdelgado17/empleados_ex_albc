defmodule Domain.Behaviours.Generic.GenericBehaviour do
  @callback generate_uuid() :: binary()
end
