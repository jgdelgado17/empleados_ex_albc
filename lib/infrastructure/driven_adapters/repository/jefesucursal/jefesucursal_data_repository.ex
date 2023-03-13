defmodule EmpleadosExAlbc.Infrastructure.Adapters.Repository.Jefesucursal.JefesucursalDataRepository do
  alias EmpleadosExAlbc.Infrastructure.Adapters.Repository.Repo
  alias EmpleadosExAlbc.Infrastructure.Adapters.Repository.Jefesucursal.Data.JefesucursalData
  # alias EmpleadosExAlbc.Domain.Model.Jefesucursal

  ## TODO: Update behaviour
  # @behaviour EmpleadosExAlbc.Domain.Behaviours.JefesucursalBehaviour

  def find_by_id(id), do: JefesucursalData |> Repo.get(id) |> to_entity

  def insert(entity) do
    case to_data(entity) |> Repo.insert do
      {:ok, entity} -> entity |> to_entity()
      error -> error
    end
  end

  defp to_entity(nil), do: nil
  defp to_entity(data) do
    ## TODO: Update Entity
    # struct(Jefesucursal, data |> Map.from_struct)
    %{}
  end

  defp to_data(entity) do
    struct(JefesucursalData, entity |> Map.from_struct)
  end
end
