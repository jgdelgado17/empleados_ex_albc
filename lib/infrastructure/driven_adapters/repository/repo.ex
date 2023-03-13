defmodule EmpleadosExAlbc.Infrastructure.Adapters.Repository.Repo do
  use Ecto.Repo,
  otp_app: :empleados_ex_albc,
  adapter: Ecto.Adapters.Postgres
end
