defmodule EmpleadosExAlbc.Domain.Behaviours.JefesucursalBehaviour do
  alias EmpleadosExAlbc.Domain.Model.Jefesucursal

  @moduledoc """
  TODO Updates description and add new functions
  """

  # @callback replace_function_name(param_one::term, param_two::term)::{:ok, true::term} | {:error, reason::term}

  @callback register(Jefesucursal.t()) :: {:ok, Jefesucursal.t()} | {:error, reason :: atom()}

  @callback find_by_id(String.t()) :: {:ok, Jefesucursal.t()} | {:error, reason :: atom()}
end
