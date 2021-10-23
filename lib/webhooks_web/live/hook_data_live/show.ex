defmodule WebhooksWeb.HookDataLive.Show do
  use WebhooksWeb, :live_view

  alias Webhooks.Hooks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:hook_data, Hooks.get_hook_data!(id))}
  end

  defp page_title(:show), do: "Show Hook data"
  defp page_title(:edit), do: "Edit Hook data"
end
