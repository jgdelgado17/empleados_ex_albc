defmodule EmpleadosExAlbc.Domain.UseCase.GetAllJefesucursalUseCase do
  alias EmpleadosExAlbc.Domain.Model.Jefesucursal
  require Logger

  @jefesucursal_behaviour Application.compile_env(:empleados_ex_albc, :jefesucursal_behaviour)

  def find_all() do
    with {:ok, _} <- Jefesucursal.find_all(),
         # {:ok, _} <- legal_validation(jefesucursal),
         {:ok, get_jefesucursal} <- find_all_jefesucursal() do
      Logger.info("Founded all jefesucursal: #{inspect(get_jefesucursal)}")
      {:ok, get_jefesucursal}
    end
  end

  def find_all_jefesucursal() do
    @jefesucursal_behaviour.find_all()
  end
end
