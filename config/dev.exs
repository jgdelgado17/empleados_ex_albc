import Config

config :empleados_ex_albc, timezone: "America/Bogota"

config :empleados_ex_albc,
  http_port: 8083,
  enable_server: true,
  secret_name: "",
  region: "",
  version: "0.0.1",
  in_test: false,
  custom_metrics_prefix_name: "empleados_ex_albc_local"

config :logger,
  level: :debug

config :empleados_ex_albc, ecto_repos: [EmpleadosExAlbc.Infrastructure.Adapters.Repository.Repo]

config :empleados_ex_albc, EmpleadosExAlbc.Infrastructure.Adapters.Repository.Repo,
  database: "empleados_ex_albc",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: 5432,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :empleados_ex_albc,
  generate_uuid_behaviour:
    EmpleadosExAlbc.Infrastructure.DrivenAdapters.Repository.Generic.UuidData,
  jefesucursal_behaviour:
    EmpleadosExAlbc.Infrastructure.Adapters.Repository.Jefesucursal.JefesucursalDataRepository
