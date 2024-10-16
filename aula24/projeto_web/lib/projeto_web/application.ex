defmodule ProjetoWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ProjetoWebWeb.Telemetry,
      ProjetoWeb.Repo,
      {DNSCluster, query: Application.get_env(:projeto_web, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ProjetoWeb.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ProjetoWeb.Finch},
      # Start a worker by calling: ProjetoWeb.Worker.start_link(arg)
      # {ProjetoWeb.Worker, arg},
      # Start to serve requests, typically the last entry
      ProjetoWebWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProjetoWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ProjetoWebWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
