defmodule JobberWeb.Schema do
  @moduledoc """
  Defines the GraphQL Schema
  """
  use Absinthe.Schema

  query do
    @desc "Get a list of users"
    field :users, list_of(:user) do
      resolve(&JobberWeb.Resolvers.Accounts.users/3)
    end

    @desc "Get a user by their id"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&JobberWeb.Resolvers.Accounts.user/3)
    end
  end

  object :user do
    field :id, non_null(:id)
    field :username, non_null(:string)
    field :avatar, :string
    field :email, non_null(:string)
  end
end
