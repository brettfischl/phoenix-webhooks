defmodule WebhooksWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  import Phoenix.LiveView

  alias Webhooks.Accounts
  alias Webhooks.Accounts.User
  alias WebhooksWeb.Router.Helpers, as: Routes

  def assign_defaults(session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        find_current_user(session)
      end)

    case socket.assigns.current_user do
      %User{} ->
        socket

      _other ->
        socket
        |> put_flash(:error, "You must log in to access this page.")
        |> redirect(to: Routes.user_session_path(socket, :new))
    end
  end

  defp find_current_user(session) do
    with user_token when not is_nil(user_token) <- session["user_token"],
         %User{} = user <- Accounts.get_user_by_session_token(user_token),
         do: user
  end

  @doc """
  Renders a component inside the `WebhooksWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal WebhooksWeb.HookDataLive.FormComponent,
        id: @hook_data.id || :new,
        action: @live_action,
        hook_data: @hook_data,
        return_to: Routes.hook_data_index_path(@socket, :index) %>
  """
  def live_modal(component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(WebhooksWeb.ModalComponent, modal_opts)
  end
end
