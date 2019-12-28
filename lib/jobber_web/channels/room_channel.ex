defmodule JobberWeb.RoomChannel do
  @moduledoc """
  Room Channel authorization for clients
  """
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    IO.inspect(socket)
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end
end
