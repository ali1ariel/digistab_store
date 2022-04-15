defmodule DigistabStore.StoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DigistabStore.Store` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        media: "some media",
        name: "some name",
        price: 42,
        quantity: 42
      })
      |> DigistabStore.Store.create_product()

    product
  end
end
