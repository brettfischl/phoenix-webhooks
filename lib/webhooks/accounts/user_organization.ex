defmodule Webhooks.Accounts.UserOrganization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_organizations" do
    field :is_current, :boolean, default: true
    field :user_id, :id
    field :organization_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_organization, attrs) do
    user_organization
    |> cast(attrs, [:is_current])
    |> validate_required([:is_current])
  end
end
