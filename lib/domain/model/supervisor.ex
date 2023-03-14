defmodule EmpleadosExAlbc.Domain.Model.Supervisor do
  defstruct [
    :id,
    :nombres,
    :apellidos,
    :fecha_ingreso,
    :jefesucursal_id
  ]

  @type t() :: %__MODULE__{
          id: binary(),
          nombres: String.t(),
          apellidos: String.t(),
          fecha_ingreso: Date.t(),
          jefesucursal_id: binary()
        }

  @spec new(nil, String.t(), String.t(), Date.t(), binary()) ::
          {:error, atom()} | {:ok, __MODULE__.t()}
  def new(id, _, _, _, _) when is_nil(id), do: {:error, :invalid_supervisor}

  def new(id, nombres, apellidos, fecha_ingreso, jefesucursal_id) do
    {
      :ok,
      %__MODULE__{
        id: id,
        nombres: nombres,
        apellidos: apellidos,
        fecha_ingreso: fecha_ingreso,
        jefesucursal_id: jefesucursal_id
      }
    }
  end

  def find_by_id(id) do
    {
      :ok,
      %__MODULE__{id: id}
    }
  end
end
