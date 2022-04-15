defmodule DigistabStore.Store.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :media, :string
    field :name, :string
    field :price, :integer
    field :quantity, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :price, :quantity, :media])
    |> validate_required([:name, :description, :price, :quantity, :media])
  end
end
