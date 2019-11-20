defmodule Jobber.Factory do
  @moduledoc """
  Factory module for creating test data.
  """
  use ExMachina.Ecto, repo: Jobber.Repo
  alias Jobber.Accounts.User

  def user_factory do
    %User{
      username: "Jane Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      avatar: "http://link-to-some-image"
    }
  end
end
