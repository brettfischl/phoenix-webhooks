defmodule Webhooks.Repo.Migrations.CreateHookData do
  use Ecto.Migration

  def change do
    create table(:hook_data) do
      add :data, :map
      add :referrer, :string
      add :params, :map
      add :method, :string
      add :hook_id, references(:hooks, on_delete: :nothing)

      timestamps()
    end

    create index(:hook_data, [:hook_id])
  end
end
