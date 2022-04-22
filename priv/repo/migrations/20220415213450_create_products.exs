defmodule DigistabStore.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :text
      add :price, :integer
      add :quantity, :integer
      add :media, {:array, :string}, null: false, default: []

      timestamps()
    end
  end
end
