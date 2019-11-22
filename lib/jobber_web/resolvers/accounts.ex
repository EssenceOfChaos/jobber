defmodule JobberWeb.Resolvers.Accounts do
  @moduledoc """
  Resolves data requested by the GraphQL API from the Ecto Repo
  """
  alias Jobber.Accounts

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def user(_, %{id: id}, _) do
    {:ok, Accounts.get_user!(id)}
  end
end
