defmodule DigistabStore.Store.Product do
  use DigistabStore.Schema
  import Ecto.Changeset

  alias DigistabStore.Store.Status
  alias DigistabStore.Store.Category

  schema "products" do
    field :description, :string
    field :media, :string
    field :name, :string
    field :price, :integer
    field :quantity, :integer

    belongs_to :status, Status, foreign_key: :status_id, on_replace: :nilify
    belongs_to :category, Category, foreign_key: :category_id, on_replace: :nilify

    field :status_select, :string, virtual: true
    field :category_select, :string, virtual: true

    has_many :products_tags, ProductTag
    has_many :tags, through: [:products_tags, :tag]

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :price, :quantity, :media])
    |> validate_required([:name, :description, :price, :quantity, :media])
    |> put_assoc(:status, Map.get(attrs, "status"))
  end
end
