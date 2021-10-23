defmodule WebhooksWeb.HookDataLive.FormComponent do
  use WebhooksWeb, :live_component

  @topic "hookdata"

  alias Webhooks.Hooks

  @impl true
  def update(%{hook_data: hook_data} = assigns, socket) do
    changeset = Hooks.change_hook_data(hook_data)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"hook_data" => hook_data_params}, socket) do
    changeset =
      socket.assigns.hook_data
      |> Hooks.change_hook_data(hook_data_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"hook_data" => hook_data_params}, socket) do
    save_hook_data(socket, socket.assigns.action, hook_data_params)
  end

  defp save_hook_data(socket, :edit, hook_data_params) do
    case Hooks.update_hook_data(socket.assigns.hook_data, hook_data_params) do
      {:ok, hook_data} ->
        WebhooksWeb.Endpoint.broadcast_from(self(), @topic, "hook_updated", hook_data)
        {:noreply,
         socket
         |> put_flash(:info, "Hook data updated successfully")
         |> assign(:hook_data, hook_data)
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end


  end

  defp save_hook_data(socket, :new, hook_data_params) do
    case Hooks.create_hook_data(hook_data_params) do
      {:ok, hook_data} ->
        WebhooksWeb.Endpoint.broadcast_from(self(), @topic, "hook_created", hook_data)
        {:noreply,
         socket
         |> put_flash(:info, "Hook data created successfully")
         |> assign(:hook_data, hook_data)
         |> push_redirect(to: socket.assigns.return_to)}


      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
