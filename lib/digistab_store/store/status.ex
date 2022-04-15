defmodule DigistabStore.Store.Status do
  use DigistabStore.Schema
  import Ecto.Changeset

  alias DigistabStore.Store.Product

  schema "status" do
    field :description, :string
    field :name, :string

    timestamps()

    has_many :products, Product
  end

  @doc false
  def changeset(status, attrs) do
    status
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
