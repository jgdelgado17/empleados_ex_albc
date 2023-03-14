defmodule EmpleadosExAlbc.Infrastructure.Adapters.Repository.Supervisor.SupervisorDataRepository do
  alias EmpleadosExAlbc.Infrastructure.Adapters.Repository.Repo
  alias EmpleadosExAlbc.Infrastructure.Adapters.Repository.Supervisor.Data.SupervisorData
  alias EmpleadosExAlbc.Domain.Model.Supervisor

  ## TODO: Update behaviour
  @behaviour EmpleadosExAlbc.Domain.Behaviours.SupervisorBehaviour

  def register(entity) do
    case to_data(entity) |> Repo.insert() do
      {:ok, entity} -> {:ok, entity |> to_entity()}
      error -> error
    end
  end

  def find_by_id(id) do
    case SupervisorData |> Repo.get!(id) do
      {:ok, entity} -> {:ok, entity |> to_entity()}
      error -> error
    end
  end

  def insert(entity) do
    case to_data(entity) |> Repo.insert() do
      {:ok, entity} -> entity |> to_entity()
      error -> error
    end
  end

  defp to_entity(nil), do: nil

  defp to_entity(data) do
    struct(Supervisor, data |> Map.from_struct())
  end

  defp to_data(entity) do
    prop = SupervisorData.changeset(%SupervisorData{}, entity |> Map.from_struct()).changes
    struct(SupervisorData, prop)
  end
end
