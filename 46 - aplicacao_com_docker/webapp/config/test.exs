import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :webapp, Webapp.Repo,
  username: System.get_env("DB_USERNAME_TEST", "danilo"),
  password: System.get_env("DB_PASSWORD_TEST", "danilo"),
  hostname: System.get_env("DB_HOSTNAME_TEST", "localhost"),
  database: System.get_env("DB_NAME_TEST", "webapp_test"),
  database: "webapp_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :webapp, WebappWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "nLQQht89xGW6/VsgLSf3td0Mi6IMKY0WP1KZtCgy4bNpHlYk9PYA7Bqyqn4g53UK",
  server: false

# In test we don't send emails
config :webapp, Webapp.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
