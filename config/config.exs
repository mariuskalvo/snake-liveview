# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :snake,
  ecto_repos: [Snake.Repo]

# Configures the endpoint
config :snake, SnakeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VhBYbV1faCSbiADZB6b6EokdaMNftRHnac2TZSpuK+nZ698DIZ4rwHKwyU96CiNW",
  render_errors: [view: SnakeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Snake.PubSub,
  live_view: [signing_salt: "aVs68z1q"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
