defmodule Infrastructure.DrivenAdapters.Rabbitmq.Rabbitmqdos do
  use AMQP
  def start_link_prueba(algo) do
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
