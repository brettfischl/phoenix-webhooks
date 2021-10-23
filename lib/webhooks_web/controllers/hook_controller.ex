defmodule WebhooksWeb.HookController do
  use WebhooksWeb, :controller


  @topic "hookdata"

  alias Webhooks.Hooks
  alias Webhooks.Hooks.Hook

  def index(conn, _params) do
    hooks = Hooks.list_hooks()
    render(conn, "index.html", hooks: hooks)
  end

  def new(conn, _params) do
    changeset = Hooks.change_hook(%Hook{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"hook" => hook_params}) do
    case Hooks.create_hook(hook_params) do
      {:ok, hook} ->
        conn
        |> put_flash(:info, "Hook created successfully.")
        |> redirect(to: Routes.hook_path(conn, :show, hook))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hook = Hooks.get_hook!(id)
    render(conn, "show.html", hook: hook)
  end

  def edit(conn, %{"id" => id}) do
    hook = Hooks.get_hook!(id)
    changeset = Hooks.change_hook(hook)
    render(conn, "edit.html", hook: hook, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hook" => hook_params}) do
    hook = Hooks.get_hook!(id)

    case Hooks.update_hook(hook, hook_params) do
      {:ok, hook} ->
        conn
        |> put_flash(:info, "Hook updated successfully.")
        |> redirect(to: Routes.hook_path(conn, :show, hook))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", hook: hook, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hook = Hooks.get_hook!(id)
    {:ok, _hook} = Hooks.delete_hook(hook)

    conn
    |> put_flash(:info, "Hook deleted successfully.")
    |> redirect(to: Routes.hook_path(conn, :index))
  end

  def receive(conn, params) do
    referrer =
      case List.keyfind(conn.req_headers, "referer", 0) do
        {"referer", referer} ->
          referer
        nil ->
          "no referrer"
      end

    [hook] = Hooks.get_hook_by_path!(params["path"])
    hook_data = %{
      hook_id: hook.id,
      method: conn.method,
      params: conn.query_params,
      data: conn.body_params,
      referrer: referrer
    }
    {_, hook_data} = Hooks.create_hook_data(hook_data)
    WebhooksWeb.Endpoint.broadcast_from(self(), @topic, "hook_created", hook_data)

    conn
    |> send_resp(201, "")
  end
end
