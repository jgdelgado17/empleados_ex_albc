defmodule EmpleadosExAlbc.Infrastructure.Adapters.Repository.Repo.Migrations.CreateJefesucursal do
  use Ecto.Migration

  def change do
    create table(:jefesucursal, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :nombres, :string
      add :apellidos, :string
      add :fecha_ingreso, :date

      timestamps()
    end
  end
end
