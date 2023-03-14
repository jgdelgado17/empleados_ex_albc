defmodule EmpleadosExAlbc.Infrastructure.Adapters.Repository.Repo.Migrations.CreateCajero do
  use Ecto.Migration

  def change do
    create table(:cajero, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:nombres, :string)
      add(:apellidos, :string)
      add(:fecha_ingreso, :date)
      add(:horario_inicio, :integer)
      add(:horario_fin, :integer)

      add(
        :supervisor_id,
        references(:supervisor, on_delete: :nothing, on_update: :update_all, type: :binary_id)
      )

      timestamps()
    end

    create(index(:cajero, [:supervisor_id]))
  end
end
