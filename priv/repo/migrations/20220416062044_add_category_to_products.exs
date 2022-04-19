defmodule DigistabStore.Repo.Migrations.AddCategoryToProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :category_id, references(:categories, type: :uuid)
    end
  end
end
