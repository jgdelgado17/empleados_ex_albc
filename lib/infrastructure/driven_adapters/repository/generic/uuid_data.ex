defmodule EmpleadosExAlbc.Infrastructure.DrivenAdapters.Repository.Generic.UuidData do
  alias EmpleadosExAlbc.Utils.IdGenerator
  @behaviour EmpleadosExAlbc.Domain.Behaviours.Generic.GenericBehaviour

  def generate_uuid() do
    IdGenerator.generate_uuid()
  end
end
