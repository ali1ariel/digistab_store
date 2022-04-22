defmodule DigistabStore.Repo.Migrations.AddPromotionalPriceToProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :promotional_price, :integer
    end

  end
end
