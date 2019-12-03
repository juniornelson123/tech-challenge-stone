# Since configuration is shared in umbrella projects, this file
# should only configure the :financial_system_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :financial_system_web,
  generators: [context_app: false]

# Configures the endpoint
config :financial_system_web, FinancialSystemWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a4UHrEPL8SxBywYK8B9v/m6o32IRkvlRwyQaINg58iq1ffsm4LK8eWGZNicFs39O",
  render_errors: [view: FinancialSystemWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FinancialSystemWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
