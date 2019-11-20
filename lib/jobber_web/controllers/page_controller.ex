defmodule JobberWeb.PageController do
  use JobberWeb, :controller

  def index(conn, _params) do
    conn
    |> IO.inspect()
    |> render("index.html")
  end
end
