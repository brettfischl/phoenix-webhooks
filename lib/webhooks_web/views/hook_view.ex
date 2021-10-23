defmodule WebhooksWeb.HookView do
  use WebhooksWeb, :view

  alias Webhooks.Hooks.Hook

  def hook_path(%Hook{} = hook) do
    "#{Routes.url(:index)}#{hook.path}"
  end
end
