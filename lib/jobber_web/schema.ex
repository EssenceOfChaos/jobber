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
    field :email, non_null(:string)
    field :avatar, :string
    field :favorites, list_of(:string)
  end
end

# SQL for updating favorites of user with id: 8
# UPDATE "public"."users" SET "favorites"='{"Apple", "Space X"}' WHERE "id"=8 RETURNING "id", "username", "encrypted_password", "email", "avatar", "inserted_at", "updated_at", "favorites";
