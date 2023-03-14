defmodule EmpleadosExAlbc.Infrastructure.Adapters.Repository.Repo.Migrations.CreateSupervisor do
  use Ecto.Migration

  def change do
    create table(:supervisor, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :nombres, :string
      add :apellidos, :string
      add :fecha_ingreso, :date
      add :jefesucursal_id, references(:jefesucursal, on_delete: :nothing, on_update: :update_all, type: :binary_id)

      timestamps()
    end

    create index(:supervisor, [:jefesucursal_id])
  end
end
