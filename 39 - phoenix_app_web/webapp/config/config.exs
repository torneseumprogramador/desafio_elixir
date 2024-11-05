# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :webapp,
  ecto_repos: [Webapp.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :webapp, WebappWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: WebappWeb.Controllers.Web.ErrorHTML, json: WebappWeb.Controllers.Api.ErrorJSON],
    layout: false
  ],
  pubsub_server: Webapp.PubSub,
  jwt_secret: System.get_env("JWT_SECRET") || "desafio_elixir_tornese",
  live_view: [signing_salt: "1qvstc3f"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
# config :swoosh, :api_client, Swoosh.ApiClient.Finch
config :swoosh, :api_client, Swoosh.ApiClient.Hackney

config :webapp, Webapp.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: System.get_env("SENDGRID_API_KEY")


# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  webapp: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  webapp: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :webapp, WebappWeb.Gettext, default_locale: "pt_BR"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
