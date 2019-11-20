defmodule JobberWeb.Plug.EnsureAuthentication do
  @moduledoc false
  use Guardian.Plug.Pipeline,
    otp_app: :jobber,
    module: Jobber.Guardian

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.EnsureAuthenticated)
  plug Guardian.Plug.LoadResource, allow_blank: true
end
