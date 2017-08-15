use Mix.Config

config :katalyst, Server,
  port: System.get_env("PORT") || 4000,
  ssl:  System.get_env("SSL")  || false
config :kserver,
  port: 8888,

# Import environment specific settings
# These settings are imported last since they override the default ones here
import_config "#{Mix.env}*.exs"