defmodule Jobber.Accounts.Guardian do
  @moduledoc """
  The Guardian implementation for using JSON Web Tokens to authenticate.
  """
  use Guardian, otp_app: :jobber
  alias Jobber.Accounts

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end

  # def resource_from_claims(_claims) do
  #   {:error, :reason_for_error}
  # end
end
