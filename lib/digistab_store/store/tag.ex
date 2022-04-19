defmodule DigistabStore.Store.Tag do
  use DigistabStore.Schema
  import Ecto.Changeset

  alias DigistabStore.Store.ProductTag

  schema "tags" do
    field :description, :string
    field :name, :string

    has_many :products_tags, ProductTag
    has_many :products, through: [:products_tags, :product]

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
