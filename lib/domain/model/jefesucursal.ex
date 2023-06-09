defmodule EmpleadosExAlbc.Domain.Model.Jefesucursal do
  @moduledoc """
  TODO Updates module description
  """

  defstruct [
    :id,
    :nombres,
    :apellidos,
    :fecha_ingreso
  ]

  @type t() :: %__MODULE__{
          id: binary(),
          nombres: String.t(),
          apellidos: String.t(),
          fecha_ingreso: Date.t()
        }

  @spec new(binary(), String.t(), String.t(), Date.t()) ::
          {:error, atom()} | {:ok, __MODULE__.t()}
  def new(id, _, _, _) when is_nil(id), do: {:error, :invalid_jefesucursal}

  def new(id, nombres, apellidos, fecha_ingreso) do
    {
      :ok,
      %__MODULE__{
        id: id,
        nombres: nombres,
        apellidos: apellidos,
        fecha_ingreso: fecha_ingreso
      }
    }
  end

  def find_by_id(id) do
    {
      :ok,
      %__MODULE__{id: id}
    }
  end

  def find_all() do
    {
      :ok,
      [%__MODULE__{}]
    }
  end

  def delete(id) do
    {
      :ok,
      %__MODULE__{id: id}
    }
  end

  def update(nombres, apellidos, fecha_ingreso) do
    {
      :ok,
      %__MODULE__{
        nombres: nombres,
        apellidos: apellidos,
        fecha_ingreso: fecha_ingreso
      }
    }
  end
end
