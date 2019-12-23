defmodule JobberWeb.PageController do
  use JobberWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:message, "Welcome Back!")
    |> IO.inspect()
    |> render("index.html")
  end
end
