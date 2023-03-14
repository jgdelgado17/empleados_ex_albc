defmodule EmpleadosExAlbc.Domain.UseCase.RegisterSupervisorUseCase do
  alias EmpleadosExAlbc.Domain.Model.Supervisor
  require Logger

  @supervisor_behaviour Application.compile_env(:empleados_ex_albc, :supervisor_behaviour)
  @generate_uuid_behaviour Application.compile_env(:empleados_ex_albc, :generate_uuid_behaviour)

  def register(data) do
    map_with_id = Map.put(data, :id, generate_uuid_supervisor())

    with {:ok, supervisor} <-
           Supervisor.new(
             map_with_id[:id],
             map_with_id[:nombres],
             map_with_id[:apellidos],
             map_with_id[:fecha_ingreso],
             map_with_id[:jefesucursal_id]
           ),
         # {:ok, _} <- legal_validation(supervisor),
         {:ok, new_supervisor} <- register_supervisor(supervisor) do
      Logger.info("New supervisor: #{inspect(new_supervisor)}")
      {:ok, new_supervisor}
    end
  end

  # defp legal_validation(supervisor) do
  #  {:ok, supervisor}
  # end

  # Behaviors

  defp register_supervisor(supervisor) do
    # {:ok, supervisor}
    @supervisor_behaviour.register(supervisor)
  end

  defp generate_uuid_supervisor() do
    @generate_uuid_behaviour.generate_uuid()
  end
end
