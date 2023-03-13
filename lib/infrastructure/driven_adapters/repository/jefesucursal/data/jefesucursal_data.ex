defmodule EmpleadosExAlbc.Infrastructure.Adapters.Repository.Jefesucursal.Data.JefesucursalData do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "jefesucursal" do
    field :apellidos, :string
    field :fecha_ingreso, :date
    field :nombres, :string
    # has_many :supervisor, EmpleadossPhoenix.Supervisores.Supervisor

    timestamps()
  end

  @doc false
  def changeset(jefesucursal, attrs) do
    jefesucursal
    |> cast(attrs, [:nombres, :apellidos, :fecha_ingreso])
    |> validate_required([:nombres, :apellidos, :fecha_ingreso])
  end
end
