defmodule Webapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WebappWeb.Telemetry,
      Webapp.Repo,
      {DNSCluster, query: Application.get_env(:webapp, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Webapp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Webapp.Finch},
      # Start a worker by calling: Webapp.Worker.start_link(arg)
      # {Webapp.Worker, arg},
      # Start to serve requests, typically the last entry
      WebappWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Webapp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WebappWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
