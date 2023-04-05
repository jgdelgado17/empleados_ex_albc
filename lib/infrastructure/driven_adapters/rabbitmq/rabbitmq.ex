defmodule EmpleadosExAlbc.Infrastructure.Adapters.Rabbitmq.Rabbitmq do
  use AMQP

  @moduledoc """
  Provides functions for your generic Da
  Example:
  def replace_me(param1, param2) do
    {:ok, param1, param2}
  end
  """
  def start_link(algo) do
    {:ok, connection} = Connection.open()
    {:ok, channel} = Channel.open(connection)

    queue_name = "cola_elixir"
    Queue.declare(channel, queue_name)
    Basic.publish(channel, "", queue_name, algo)
    Basic.consume(channel, queue_name, nil, no_ack: true)
    IO.puts("Consumiendo.....")
    # message = Basic.get(channel, queue_name)
    # IO.inspect(message)

    # {:ok, consumer} = Basic.consume(channel, queue_name)

    # receive do
    #   {:basic_deliver, payload, _meta} ->
    #     IO.puts("Mensaje recibido: #{payload}")
    #     Basic.ack(channel, payload.delivery_tag)
    # end
  end
end
