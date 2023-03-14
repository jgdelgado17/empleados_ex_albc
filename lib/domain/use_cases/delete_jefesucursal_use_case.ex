defmodule EmpleadosExAlbc.Domain.UseCase.DeleteJefesucursalUseCase do
  alias EmpleadosExAlbc.Domain.Model.Jefesucursal
  require Logger

  @jefesucursal_behaviour Application.compile_env(:empleados_ex_albc, :jefesucursal_behaviour)

  def delete(data) do
    with {:ok, jefesucursal} <- Jefesucursal.delete(data[:id]),
         # {:ok, _} <- legal_validation(jefesucursal),
         {:ok, get_jefesucursal} <- delete_jefesucursal(Map.get(jefesucursal, :id)) do
      Logger.info("Delete jefesucursal: #{inspect(get_jefesucursal)}")
      {:ok, get_jefesucursal}
    end
  end

  def delete_jefesucursal(id) do
    @jefesucursal_behaviour.delete(id)
  end
end
