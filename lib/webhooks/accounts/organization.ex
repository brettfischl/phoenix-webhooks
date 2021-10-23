defmodule Webhooks.Accounts.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :name, :string

    many_to_many :users, Webhooks.Accounts.User, join_through: Webhooks.Accounts.UserOrganization, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
