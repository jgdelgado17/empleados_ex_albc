import Config

config :empleados_ex_albc, timezone: "America/Bogota"

config :empleados_ex_albc,
       http_port: 8083,
       enable_server: true,
       secret_name: "",
       region: "",
       version: "0.0.1",
       in_test: true,
       custom_metrics_prefix_name: "empleados_ex_albc_local"

config :logger,
       level: :debug
