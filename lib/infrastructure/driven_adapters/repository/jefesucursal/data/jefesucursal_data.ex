defmodule EmpleadosExAlbc.Infrastructure.Adapters.Repository.Jefesucursal.Data.JefesucursalData do
  use Ecto.Schema

  ## TODO: Add schema definition
  # Types https://hexdocs.pm/ecto/Ecto.Schema.html#module-primitive-types

  schema "jefesucursal" do
    field :name, :string
    #field :creation_date, :utc_datetime
    #field :update_date, :utc_datetime
  end
end
