defmodule JobberWeb.PageControllerTest do
  @moduledoc """
  Testing the Page Controller
  """
  use JobberWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Jobber!"
  end
end
