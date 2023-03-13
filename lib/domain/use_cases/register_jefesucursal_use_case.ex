defmodule EmpleadosExAlbc.Domain.UseCase.RegisterJefesucursalUseCase do
  alias EmpleadosExAlbc.Domain.Model.Jefesucursal
  require Logger

  @jefesucursal_behaviour Application.compile_env(:empleados_ex_albc, :jefesucursal_behaviour)
  @generate_uuid_behavior Application.compile_env(:empleados_ex_albc, :generate_uuid_behavior)

  def register(data) do
    map_with_id = Map.put(data, :id, generate_uuid_jefesucursal())

    with {:ok, jefesucursal} <-
           Jefesucursal.new(
             map_with_id[:id],
             map_with_id[:nombres],
             map_with_id[:apellidos],
             map_with_id[:fecha_ingreso]
           ),
         # {:ok, _} <- legal_validation(jefesucursal),
         {:ok, new_jefesucursal} <- register_jefesucursal(jefesucursal) do
      Logger.info("New jefesucursal: #{inspect(new_jefesucursal)}")
      {:ok, new_jefesucursal}
    end
  end

  # defp legal_validation(jefesucursal) do
  #  {:ok, jefesucursal}
  # end

  # Behaviors

  defp register_jefesucursal(jefesucursal) do
    # {:ok, jefesucursal}
    @jefesucursal_behaviour.register(jefesucursal)
  end

  defp generate_uuid_jefesucursal() do
    @generate_uuid_behavior.generate_uuid()
  end
end
