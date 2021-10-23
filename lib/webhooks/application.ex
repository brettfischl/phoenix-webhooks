defmodule Webhooks.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Webhooks.Repo,
      # Start the Telemetry supervisor
      WebhooksWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Webhooks.PubSub},
      # Start the Endpoint (http/https)
      WebhooksWeb.Endpoint
      # Start a worker by calling: Webhooks.Worker.start_link(arg)
      # {Webhooks.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Webhooks.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WebhooksWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
