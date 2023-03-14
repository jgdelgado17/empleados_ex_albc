defmodule EmpleadosExAlbc.Domain.Behaviours.SupervisorBehaviour do
  alias EmpleadosExAlbc.Domain.Model.Supervisor

  @callback register(Supervisor.t()) :: {:ok, Supervisor.t()} | {:error, reason :: atom()}

  @callback find_by_id(String.t()) :: {:ok, Supervisor.t()} | {:error, reason :: atom()}
end
