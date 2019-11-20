defmodule Jobber.AccountsTest do
  @moduledoc """
      Unit tests for the User model.
  """
  use Jobber.DataCase

  alias Jobber.Accounts
  import Jobber.Factory

  describe "users" do
    alias Jobber.Accounts.User

    @valid_attrs %{
      email: "example1@aol.com",
      password: "supersecret123",
      username: "cooldude1980"
    }
    @update_attrs %{
      password: "supersecret321",
      username: "coolestdude80"
    }
    @invalid_attrs %{encrypted_password: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.username == "cooldude1980"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.username == "coolestdude80"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  ## Factory Tests ##
  test "building a user with default values" do
    user = build(:user)
    assert user.username == "Jane Smith"
  end
end
