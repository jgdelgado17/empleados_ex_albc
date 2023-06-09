defmodule EmpleadosExAlbc.Infrastructure.EntryPoint.ApiRest do
  @moduledoc """
  Access point to the rest exposed services
  """
  # alias EmpleadosExAlbc.Utils.DataTypeUtils
  alias EmpleadosExAlbc.Infrastructure.Adapters.Rabbitmq.Rabbitmq
  alias EmpleadosExAlbc.Domain.UseCases.Supervisor.RegisterSupervisorUseCase
  alias EmpleadosExAlbc.Domain.UseCases.Jefesucursal.RegisterJefesucursalUseCase
  alias EmpleadosExAlbc.Domain.UseCases.Jefesucursal.GetJefesucursalUseCase
  alias EmpleadosExAlbc.Domain.UseCases.Jefesucursal.GetAllJefesucursalUseCase
  alias EmpleadosExAlbc.Domain.UseCases.Jefesucursal.DeleteJefesucursalUseCase
  alias EmpleadosExAlbc.Domain.UseCases.Jefesucursal.UpdateJefesucursalUseCase
  alias EmpleadosExAlbc.Infrastructure.EntryPoint.ErrorHandler
  require Logger
  use Plug.Router
  use Timex

  plug(CORSPlug,
    methods: ["GET", "POST", "PUT", "DELETE"],
    origin: [~r/.*/],
    headers: ["Content-Type", "Accept", "User-Agent"]
  )

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison)
  plug(Plug.Telemetry, event_prefix: [:empleados_ex_albc, :plug])
  plug(:dispatch)

  forward(
    "/empleados_ex_albc/api/health",
    to: PlugCheckup,
    init_opts:
      PlugCheckup.Options.new(
        json_encoder: Jason,
        checks: EmpleadosExAlbc.Infrastructure.EntryPoint.HealthCheck.checks()
      )
  )

  get "/empleados_ex_albc/api/hello/" do
    build_response("Hello World", conn)
  end

  defp queueMQ(entidad, evento) do
    entidad = entidad |> Map.put(:event, evento)
    Rabbitmq.publish(inspect(entidad, pretty: true))
    Rabbitmq.consume()
  end

  post "/empleados_ex_albc/api/jefesucursal" do
    params_map = conn.params |> Map.new(fn {key, value} -> {String.to_atom(key), value} end)

    case RegisterJefesucursalUseCase.register(params_map) do
      {:ok, jefesucursal} ->
        jefesucursal |> build_response(conn)
        queueMQ(jefesucursal, "Jefe sucursal creado")

      {:error, error} ->
        %{status: 500, body: error} |> build_response(conn)
    end
  end

  put "/empleados_ex_albc/api/jefesucursal/:id" do
    params_map = conn.params |> Map.new(fn {key, value} -> {String.to_atom(key), value} end)

    case UpdateJefesucursalUseCase.update(id, params_map) do
      {:ok, jefesucursal} ->
        jefesucursal |> build_response(conn)
        queueMQ(jefesucursal, "Jefe sucursal actualizado")

      {:error, error} ->
        %{status: 500, body: error} |> build_response(conn)
    end
  end

  get "/empleados_ex_albc/api/jefesucursal/" do
    case GetAllJefesucursalUseCase.find_all() do
      {:ok, jefesucursal} ->
        Enum.map(jefesucursal, fn mapa ->
          Map.drop(mapa, [:__meta__, :inserted_at, :updated_at, :supervisor])
        end)
        |> build_response(conn)

      {:error, error} ->
        %{status: 500, body: error} |> build_response(conn)
    end
  end

  get "/empleados_ex_albc/api/jefesucursal/:id" do
    jefesucursal = GetJefesucursalUseCase.find_by_id(%{id: id})
    jefesucursal = Map.drop(jefesucursal, [:__meta__, :inserted_at, :updated_at, :supervisor])
    queueMQ(jefesucursal, "Jefe sucursal consultado")
    build_response(jefesucursal, conn)
  end

  delete "/empleados_ex_albc/api/jefesucursal/:id" do
    case DeleteJefesucursalUseCase.delete(%{id: id}) do
      {:ok, jefesucursal} -> jefesucursal |> build_response(conn)
      {:error, error} -> %{status: 500, body: error} |> build_response(conn)
    end
  end

  post "/empleados_ex_albc/api/supervisor" do
    params_map = conn.params |> Map.new(fn {key, value} -> {String.to_atom(key), value} end)

    case RegisterSupervisorUseCase.register(params_map) do
      {:ok, supervisor} -> supervisor |> build_response(conn)
      {:error, error} -> %{status: 500, body: error} |> build_response(conn)
    end
  end

  def build_response(%{status: status, body: body}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(body))
  end

  def build_response(response, conn), do: build_response(%{status: 200, body: response}, conn)

  match _ do
    conn
    |> handle_not_found(Logger.level())
  end

  defp handle_error(error, conn) do
    error
    |> ErrorHandler.build_error_response()
    |> build_response(conn)
  end

  defp handle_bad_request(error, conn) do
    error
    |> ErrorHandler.build_error_response()
    |> build_bad_request_response(conn)
  end

  defp build_bad_request_response(response, conn) do
    build_response(%{status: 400, body: response}, conn)
  end

  defp handle_not_found(conn, :debug) do
    %{request_path: path} = conn
    body = Poison.encode!(%{status: 404, path: path})
    send_resp(conn, 404, body)
  end

  defp handle_not_found(conn, _level) do
    send_resp(conn, 404, "")
  end
end
