defmodule DigistabStore.Store.ProductTag do
  use DigistabStore.Schema
  import Ecto.Changeset

  alias DigistabStore.Store.Product
  alias DigistabStore.Store.Tag

  schema "products_tags" do
    belongs_to :product, Product, foreign_key: :product_id, on_replace: :nilify
    belongs_to :tag, Tag, foreign_key: :tag_id, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(product_tag, attrs) do
    product_tag
    |> put_assoc(:product, Map.get(attrs, "product"))
    |> put_assoc(:tag, Map.get(attrs, "tag"))
  end
end
