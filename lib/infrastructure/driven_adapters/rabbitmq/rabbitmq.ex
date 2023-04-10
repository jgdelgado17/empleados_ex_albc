defmodule EmpleadosExAlbc.Infrastructure.Adapters.Rabbitmq.Rabbitmq do
  use AMQP

  defp start_link do
    Connection.open()
  end

  defp stop_link(conn) do
    Connection.close(conn)
  end

  defp queue_name() do
    "cola_elixir"
  end

  def publish(message) do
    with {:ok, connection} <- start_link(),
         {:ok, channel} <- Channel.open(connection),
         {:ok, _} <- Queue.declare(channel, queue_name()) do
      Basic.publish(channel, "", queue_name(), message)
      IO.puts("Publicando mensaje......... #{message}")
      stop_link(connection)
    end
  end

  def consume() do
    with {:ok, connection} <- start_link(),
         {:ok, channel} <- Channel.open(connection),
         {:ok, _} <- Queue.declare(channel, queue_name()),
         {:ok, _} <- Basic.consume(channel, queue_name(), nil, no_ack: true) do
      IO.puts("Consumiendo mensajes encolados..........")
      stop_link(connection)
    end
  end

end
