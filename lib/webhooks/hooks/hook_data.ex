defmodule Webhooks.Hooks.HookData do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hook_data" do
    field :data, :map
    field :method, :string
    field :params, :map
    field :referrer, :string

    belongs_to :hook, Webhooks.Hooks.Hook

    timestamps()
  end

  @doc false
  def changeset(hook_data, attrs) do
    hook_data
    |> cast(attrs, [:data, :referrer, :params, :method, :hook_id])
    |> validate_required([:referrer, :method, :hook_id])
  end
end
