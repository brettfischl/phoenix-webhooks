defmodule Webhooks.Repo do
  use Ecto.Repo,
    otp_app: :webhooks,
    adapter: Ecto.Adapters.Postgres
end
