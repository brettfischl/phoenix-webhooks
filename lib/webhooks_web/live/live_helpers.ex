defmodule WebhooksWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

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
