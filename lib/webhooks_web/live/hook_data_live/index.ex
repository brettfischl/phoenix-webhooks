defmodule WebhooksWeb.HookDataLive.Index do
  use WebhooksWeb, :live_view

  alias Webhooks.Hooks
  alias Webhooks.Hooks.HookData

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :hook_data_collection, list_hook_data())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Hook data")
    |> assign(:hook_data, Hooks.get_hook_data!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Hook data")
    |> assign(:hook_data, %HookData{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Hook data")
    |> assign(:hook_data, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    hook_data = Hooks.get_hook_data!(id)
    {:ok, _} = Hooks.delete_hook_data(hook_data)

    {:noreply, assign(socket, :hook_data_collection, list_hook_data())}
  end

  defp list_hook_data do
    Hooks.list_hook_data()
  end
end
