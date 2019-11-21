defmodule Jobber.Accounts.User do
  @moduledoc """
  The User model
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Jobber.Accounts.Encryption

  schema "users" do
    field :avatar, :string
    field :email, :string
    field :encrypted_password, :string
    field :username, :string

    ## Virtual Fields ##
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    timestamps()
  end

  @required_fields ~w(username password email)a
  @optional_fields ~w(avatar)a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> validate_format(:email, ~r/(\w+)@([\w.]+)/)
    |> validate_format(:username, ~r/^[a-z0-9][a-z0-9]+[a-z0-9]$/i)
    |> validate_length(:username, min: 3)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> downcase_username
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)

    if password do
      encrypted_password = Encryption.hash_password(password)
      put_change(changeset, :encrypted_password, encrypted_password)
    else
      changeset
    end
  end

  defp downcase_username(changeset) do
    update_change(changeset, :username, &String.downcase/1)
  end
end
