use Mix.Config

config :katalyst,
  port: System.get_env("PORT") || 4000,
  ssl:  System.get_env("SSL")  || false

# Import environment specific settings
# These settings are imported last since they override the default ones here
import_config "#{Mix.env}*.exs"