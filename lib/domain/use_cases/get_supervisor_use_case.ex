defmodule EmpleadosExAlbc.Domain.UseCase.GetSupervisorUseCase do
  alias EmpleadosExAlbc.Domain.Model.Supervisor
  require Logger

  @supervisor_behaviour Application.compile_env(:empleados_ex_albc, :supervisor_behaviour)

  def find_by_id(data) do
    with {:ok, supervisor} <- Supervisor.find_by_id(data[:id]),
         # {:ok, _} <- legal_validation(supervisor),
         {:ok, get_supervisor} <- find_by_id_supervisor(Map.get(supervisor, :id)) do
      Logger.info("Founded supervisor: #{inspect(get_supervisor)}")
      {:ok, get_supervisor}
    end
  end

  def find_by_id_supervisor(id) do
    @supervisor_behaviour.find_by_id(id)
  end
end
