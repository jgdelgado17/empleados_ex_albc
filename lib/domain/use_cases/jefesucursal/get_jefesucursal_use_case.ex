defmodule EmpleadosExAlbc.Domain.UseCases.Jefesucursal.GetJefesucursalUseCase do
  alias EmpleadosExAlbc.Domain.Model.Jefesucursal
  require Logger

  @jefesucursal_behaviour Application.compile_env(:empleados_ex_albc, :jefesucursal_behaviour)

  def find_by_id(data) do
    with {:ok, jefesucursal} <- Jefesucursal.find_by_id(data[:id]),
         # {:ok, _} <- legal_validation(jefesucursal),
         {:ok, get_jefesucursal} <- find_by_id_jefesucursal(Map.get(jefesucursal, :id)) do
      Logger.info("Founded jefesucursal: #{inspect(get_jefesucursal)}")
      {:ok, get_jefesucursal}
    end
  end

  def find_by_id_jefesucursal(id) do
    @jefesucursal_behaviour.find_by_id(id)
  end
end
