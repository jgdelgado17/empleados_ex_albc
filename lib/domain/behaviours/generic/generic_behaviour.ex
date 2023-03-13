defmodule EmpleadosExAlbc.Domain.Behaviours.Generic.GenericBehaviour do
  @callback generate_uuid() :: binary()
end
