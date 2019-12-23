defmodule Jobber.Accounts.Company do
  @moduledoc """
  The Company Model
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :name, :string
    field :logo, :string
    field :industry, :string
    field :year_founded, :string
    many_to_many :users, Jobber.Accounts.User, join_through: "users_companies"
  end

  @required_fields ~w(name industry year_founded)a
  @optional_fields ~w(logo)a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end
end
