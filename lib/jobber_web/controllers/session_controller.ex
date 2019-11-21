defmodule JobberWeb.SessionController do
  use JobberWeb, :controller

  alias Jobber.Accounts
  # alias Ueberauth.Strategy.Helpers
  # alias Lynx.Accounts.UserFromAuth
  # plug(Ueberauth)

  def new(conn, _) do
    render(conn, "new.html")
  end

  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> Accounts.login(user)
        |> put_session(:current_user_id, user.id)
        |> assign(:fake_news, "idk;alksdj")
        |> put_flash(:info, "Successfully authenticated as " <> user.email <> ".")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Accounts.logout()
    |> put_flash(:success, "You've been successfully logged out")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def logout(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> assign(:user_signed_in?, false)
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  #### Callbacks for Auth0 & Ueberauth ###

  #   def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
  #     conn
  #     |> put_flash(:error, "Failed to authenticate.")
  #     |> redirect(to: "/")
  #   end

  #   def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
  #     case UserFromAuth.find_or_create(auth) do
  #       {:ok, user} ->
  #         Accounts.find_or_add(user)

  #         conn
  #         |> put_flash(:info, "Successfully authenticated as " <> user.name <> ".")
  #         # |> put_session(:current_user, user) # user is an Auth0 user object
  #         # store user_id (user_auth.id) to retrieve user object later
  #         |> Accounts.login(user)
  #         |> redirect(to: "/")

  #       {:error, reason} ->
  #         conn
  #         |> put_flash(:error, reason)
  #         |> redirect(to: "/")
  #     end
  #   end
end
