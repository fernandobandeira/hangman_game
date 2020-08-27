# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config



config :gallows_web,
  generators: [context_app: :gallows]

# Configures the endpoint
config :gallows_web, GallowsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "41w1VC+Ccdw5amqL0NC2yXPfpAPuFbuztD/zSpixrN7HeBCXqcXB91QUKzQ44wua",
  render_errors: [view: GallowsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Gallows.PubSub,
  live_view: [signing_salt: "wkpEHvsy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
