defmodule DigistabStore.Repo.Migrations.AddStatusToProducts do
  use Ecto.Migration

  def change do
    alter table(:products, primary_key: false) do
      add :status_id, references(:status, type: :uuid)
    end
  end
end
