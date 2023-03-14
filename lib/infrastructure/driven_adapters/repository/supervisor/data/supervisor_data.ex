defmodule EmpleadosExAlbc.Infrastructure.Adapters.Repository.Supervisor.Data.SupervisorData do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  # @derive {Jason.Encoder, except: [:cajero]}
  # @derive {Jason.Encoder, only: [:nombres, :apellidos, :fecha_ingreso, :jefesucursal_id]}
  schema "supervisor" do
    field :apellidos, :string
    field :fecha_ingreso, :date
    field :nombres, :string
    # has_many :cajero, EmpleadossPhoenix.Cajeros.Cajero
    belongs_to :jefesucursal, EmpleadosExAlbc.Infrastructure.Adapters.Repository.Jefesucursal.Data.JefesucursalData

    timestamps()
  end

  @doc false
  def changeset(supervisor, attrs) do
    supervisor
    |> cast(attrs, [:nombres, :apellidos, :fecha_ingreso, :jefesucursal_id])
    |> validate_required([:nombres, :apellidos, :fecha_ingreso, :jefesucursal_id])
  end
end
