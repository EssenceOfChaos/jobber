defmodule Jobber.Accounts.Encryption do
  @moduledoc """
  Responsible for encrypting user passwords before they are stored in the database.
  """

  alias Jobber.Accounts.User

  def hash_password(password), do: Argon2.hash_pwd_salt(password)

  def validate_password(%User{} = user, password), do: Argon2.check_pass(user, password)
end
