# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ifsc,
  ecto_repos: [Ifsc.Repo]

# Configures the endpoint
config :ifsc, IfscWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AasJAnzFcflOcEZNsVANzyMbC5Hdfmnhz7Ij1y8ig031u6DQQZi7y7U/4+00hxOA",
  render_errors: [view: IfscWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Ifsc.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
