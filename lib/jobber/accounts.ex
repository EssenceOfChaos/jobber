defmodule Jobber.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Plug.Conn
  import Ecto.Query, warn: false
  alias Jobber.Repo

  alias Jobber.Accounts.{User, Company, Guardian}

  @doc """
  Returns the list of users.
  """
  def list_users do
    Repo.all(User)
  end

  def get_user(id), do: Repo.get(User, id)

  @doc """
  Gets a single user.
  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_email(email) do
    query = Ecto.Query.from(u in User, where: u.email == ^email)
    Repo.one(query)
  end

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def add_user_to_company(%User{} = user, company_id) do
    get_company!(company_id)
    |> change_company()
    |> Ecto.Changeset.put_assoc(:users, [user])
    |> Repo.update!()
  end

  ####### Dealing with authentication #######

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
    |> assign(:user_signed_in?, true)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
    |> put_user_token(user)
  end

  def logout(conn) do
    conn
    |> assign(:user_signed_in?, false)
    |> configure_session(drop: true)
    |> Guardian.Plug.sign_out()
  end

  def get_current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def authenticate_user(email, given_password) do
    query = Ecto.Query.from(u in User, where: u.email == ^email)

    Repo.one(query)
    |> check_password(given_password)
  end

  def load_current_user(conn, _) do
    conn
    |> assign(:current_user, Guardian.Plug.current_resource(conn))
    |> put_user_token(Guardian.Plug.current_resource(conn))
  end

  ## Private Functions ##
  defp check_password(nil, _), do: {:error, "Incorrect email or password"}

  defp check_password(user, given_password) do
    case Argon2.verify_pass(given_password, user.encrypted_password) do
      true -> {:ok, user}
      false -> {:error, "Incorrect email or password"}
    end
  end

  defp put_user_token(conn, user) do
    if user != nil do
      token = Phoenix.Token.sign(conn, "user socket", user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

  ## Company Context ##
  def list_companies do
    Repo.all(Company)
    |> Repo.preload(:users)
  end

  def get_company(id) do
    Repo.get!(Company, id)
    |> Repo.preload([:users])
  end

  def get_company!(id), do: Repo.get!(Company, id)

  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  def change_company(%Company{} = company) do
    Company.changeset(company, %{})
  end

  # Private functions
  defp put_user(changeset, user) do
    Ecto.Changeset.put_assoc(changeset, :user, user)
  end
end
