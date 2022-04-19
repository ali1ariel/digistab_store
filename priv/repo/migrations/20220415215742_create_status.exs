defmodule DigistabStore.Repo.Migrations.CreateStatus do
  use Ecto.Migration

  def change do
    create table(:status, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :text

      timestamps()
    end
  end
end
