# Sending example
{:ok, connection} = AMQP.Connection.open()
{:ok, channel} = AMQP.Channel.open(connection)
AMQP.Queue.declare(channel, "hello")
AMQP.Basic.publish(channel, "", "hello", "Hello World!")
IO.puts(" [x] Sent 'Hello World!'")
AMQP.Connection.close(connection)

defp establish_new_connection do
  case AMQP.Connection.open(connection_options()) do
    {:ok, conn} ->
      Process.link(conn.pid)
      {:ok, {conn, %{}}}

    {:error, reason} ->
      IO.puts("failed for #{inspect(reason)}")
      :timer.sleep(5_000)
      establish_new_connection()
  end
end

# defmodule MyApp.Consumer do

#   ...

#       def start_link do
#         GenServer.start_link(__MODULE__, :ok, [name: __MODULE__])
#       end

#       def init() do
#         MyApp.AMQPConnectionManager.request_channel(__MODULE__)
#         {:ok, nil}
#       end
#    --
#       def channel_available(chan) do
#         GenServer.cast(__MODULE__, {:channel_available, chan})
#       end

#       def handle_cast({:channel_available, chan}, _state) do
#         bind_to_queue chan
#         {:noreply, chan}
#       end

# defmodule MyApp.AMQPConnectionManager do

#   ...

#     def request_channel(consumer) do
#       GenServer.cast(__MODULE__, {:chan_request, consumer})
#     end

#     def handle_cast({:chan_request, consumer}, {conn, channel_mappings}) do
#       new_mapping = store_channel_mapping(conn, consumer, channel_mappings)
#       channel = Map.get(new_mapping, consumer)
#       consumer.channel_available(channel)

#       {:noreply, {conn, new_mapping}}
#     end

#     defp store_channel_mapping(conn, consumer, channel_mappings) do
#       Map.put_new_lazy(channel_mappings, consumer, fn() -> create_channel(conn) end)
#     end

#     defp create_channel conn do
#       {:ok, chan} = Channel.open(conn)
#       chan
#     end
