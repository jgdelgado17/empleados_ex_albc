defmodule EmpleadosExAlbc.Infrastructure.Adapters.Repository.Jefesucursal.JefesucursalDataRepository do
  alias EmpleadosExAlbc.Infrastructure.Adapters.Repository.Repo
  alias EmpleadosExAlbc.Infrastructure.Adapters.Repository.Jefesucursal.Data.JefesucursalData
  alias EmpleadosExAlbc.Domain.Model.Jefesucursal

  ## TODO: Update behaviour
  @behaviour EmpleadosExAlbc.Domain.Behaviours.JefesucursalBehaviour

  def register(entity) do
    case to_data(entity) |> Repo.insert() do
      {:ok, entity} -> {:ok, entity |> to_entity()}
      error -> error
    end
  end

  def find_by_id(id) do
    case JefesucursalData |> Repo.get!(id) do
      {:ok, entity} -> {:ok, entity |> to_entity()}
      error -> error
    end
  end

  def find_all() do
    {:ok, JefesucursalData |> Repo.all()}
  end

  def delete(id) do
    jefesucursal = Repo.get!(JefesucursalData, id)
    case Repo.delete jefesucursal do
      {:ok, entity} -> {:ok, entity |> to_entity}
      error -> error
    end

    # jefesucursal = find_by_id(id)

    # case to_data(jefesucursal) |> Repo.delete() do
    #   {:ok, entity} -> {:ok, entity |> to_entity()}
    #   error -> error
    # end
  end

  def insert(entity) do
    case to_data(entity) |> Repo.insert() do
      {:ok, entity} -> entity |> to_entity()
      error -> error
    end
  end

  defp to_entity(nil), do: nil

  defp to_entity(data) do
    struct(Jefesucursal, data |> Map.from_struct())
  end

  defp to_data(entity) do
    prop = JefesucursalData.changeset(%JefesucursalData{}, entity |> Map.from_struct()).changes
    struct(JefesucursalData, prop)
  end
end
