defmodule WebhooksWeb.HookView do
  use WebhooksWeb, :view
  use WebhooksWeb, :live_view

  alias Webhooks.Hooks.Hook

  def hook_path(conn, %Hook{} = hook) do
    Routes.hook_url(conn, :receive, hook.path)
  end
end
