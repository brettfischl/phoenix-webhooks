defmodule Webhooks.Hooks.Hook do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hooks" do
    field :path, :string
    field :organization_id, :id
    field :name, :string
    field :description, :string

    has_many :hook_datas, Webhooks.Hooks.HookData

    timestamps()
  end

  @doc false
  def changeset(hook, attrs) do
    hook
    |> cast(attrs, [:path, :organization_id, :name, :description])
    |> validate_required([:path, :organization_id, :name])
  end
end
