defmodule Webhooks.Repo.Migrations.CreateHooks do
  use Ecto.Migration

  def change do
    create table(:hooks) do
      add :path, :string
      add :name, :string
      add :description, :string
      add :organization_id, references(:organizations, on_delete: :nothing)

      timestamps()
    end

    create index(:hooks, [:organization_id])
  end
end
