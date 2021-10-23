defmodule Webhooks.Hooks.Hook do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hooks" do
    field :path, :string
    field :organization_id, :id

    has_many :hook_datas, Webhooks.Hooks.HookData

    timestamps()
  end

  @doc false
  def changeset(hook, attrs) do
    hook
    |> cast(attrs, [:path])
    |> validate_required([:path])
  end
end
