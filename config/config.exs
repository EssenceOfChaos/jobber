# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :jobber,
  ecto_repos: [Jobber.Repo]

# Configures the endpoint
config :jobber, JobberWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oFV/aH0VSjfz79fqfvOYQ5bhqoJncpVPxE4cEbuwiY7G8uxosX12Xl2Hfp0wKxsN",
  render_errors: [view: JobberWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Jobber.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config(:jobber, Jobber.Accounts.Guardian,
  issuer: "jobber",
  secret_key: "yEA4EfMmH3UF6S+D2xBLh5GdPUXSxQ38JS9LgzBpNdLKJVVX3rQJCqOV2nubtuDX"
)

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
