defmodule EmpleadosExAlbc.Domain.UseCases.Jefesucursal.UpdateJefesucursalUseCase do
  alias EmpleadosExAlbc.Domain.Model.Jefesucursal
  require Logger

  @jefesucursal_behaviour Application.compile_env(:empleados_ex_albc, :jefesucursal_behaviour)

  def update(id, data) do
    with {:ok, jefesucursal} <-
           Jefesucursal.update(
             data[:nombres],
             data[:apellidos],
             data[:fecha_ingreso]
           ),
         {:ok, update_jefesucursal} <- update_jefesucursal(id, jefesucursal) do
      Logger.info("Update jefesucursal: #{inspect(update_jefesucursal)}")
      {:ok, update_jefesucursal}
    end
  end

  defp update_jefesucursal(id, jefesucursal) do
    @jefesucursal_behaviour.update(id, jefesucursal)
  end
end
