defmodule Jobber.Repo do
  use Ecto.Repo,
    otp_app: :jobber,
    adapter: Ecto.Adapters.Postgres
end
