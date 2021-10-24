defmodule WebhooksWeb.HookDataLive.Index do
  use WebhooksWeb, :live_view

  alias Webhooks.Hooks
  alias Webhooks.Hooks.HookData

  @topic "hookdata"

  @impl true
  def handle_info(%{event: "hook_created", payload: hook_data, topic: @topic}, socket) do
    {:noreply, assign(socket, hook_data_collection: [hook_data | socket.assigns.hook_data_collection])}
  end

  @impl true
  def handle_info(%{event: "hook_deleted", payload: hook_data, topic: @topic}, socket) do
    updated_collection =
      socket.assigns.hook_data_collection
      |> Enum.filter(fn wd -> wd.id != hook_data.id end)
    {:noreply, assign(socket, :hook_data_collection, updated_collection)}
  end

  @impl true
  def mount(%{"hook_id" => hook_id}, session, socket) do
    session = assign_defaults(session, socket)
    org_id = List.first(session.assigns.current_user.organizations).id
    case Hooks.authorize_hook_data(hook_id, org_id) do
      [hook] ->
        WebhooksWeb.Endpoint.subscribe(@topic)
        {:ok, assign(socket, %{
          hook_data_collection: list_hook_data(hook_id, 0),
          hook: hook
        })}

      [] ->
        redirect =
          socket
          |> put_flash(:error, "You don't have access to that hook.")
          |> push_redirect(to: Routes.hook_path(socket, :index))
        {:ok, redirect}
    end
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id, "hook_id" => hook_id}) do
    socket
    |> assign(:page_title, "Edit Hook data")
    |> assign(:hook_data, Hooks.get_hook_data!(id))
    |> assign(:hook, Hooks.get_hook!(hook_id))
  end

  defp apply_action(socket, :new, %{"hook_id" => hook_id}) do
    socket
    |> assign(:page_title, "New Hook data")
    |> assign(:hook, Hooks.get_hook!(hook_id))
    |> assign(:hook_data, %HookData{})
  end

  defp apply_action(socket, :index, %{"hook_id" => hook_id}) do
    socket
    |> assign(:page_title, "Listing Hook data")
    |> assign(:hook, Hooks.get_hook!(hook_id))
    |> assign(:hook_data, nil)
  end


  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    hook_data = Hooks.get_hook_data!(id)
    {:ok, deleted} = Hooks.delete_hook_data(hook_data)

    WebhooksWeb.Endpoint.broadcast_from(self(), @topic, "hook_deleted", deleted)

    hook_data = list_hook_data(hook_data.hook_id, 0)
    {:noreply, assign(socket, :hook_data_collection, hook_data)}
  end

  defp list_hook_data(hook_id, page) do
    case hook_id do
      nil -> []
      hook_id -> Hooks.list_hook_data(hook_id, page, 10)
    end
  end
end
