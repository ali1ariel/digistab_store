defmodule DigistabStore.Repo.Migrations.CreateProductsTags do
  use Ecto.Migration

  def change do
    create table(:products_tags, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :product_id, references(:products, on_delete: :nothing, type: :uuid)
      add :tag_id, references(:tags, on_delete: :nothing, type: :uuid)

      timestamps()
    end

    create index(:products_tags, [:product_id])
    create index(:products_tags, [:tag_id])
  end
end
