defmodule JobberWeb.Plug.Authentication do
  @moduledoc false
  use Guardian.Plug.Pipeline,
    otp_app: :jobber,
    error_handler: JobberWeb.GuardianErrorHandler,
    module: Jobber.Accounts.Guardian

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.LoadResource, allow_blank: true
end
