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

  @doc """
  Generate a status.
  """
  def status_fixture(attrs \\ %{}) do
    {:ok, status} =
      attrs
      |> Enum.into(%{
        description: "some description",
        id: "7488a646-e31f-11e4-aace-600308960662",
        name: "some name"
      })
      |> DigistabStore.Store.create_status()

    status
  end

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        description: "some description",
        id: "7488a646-e31f-11e4-aace-600308960662",
        name: "some name"
      })
      |> DigistabStore.Store.create_category()

    category
  end

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        description: "some description",
        id: "7488a646-e31f-11e4-aace-600308960662",
        name: "some name"
      })
      |> DigistabStore.Store.create_tag()

    tag
  end

  @doc """
  Generate a product_tag.
  """
  def product_tag_fixture(attrs \\ %{}) do
    {:ok, product_tag} =
      attrs
      |> Enum.into(%{
        id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> DigistabStore.Store.create_product_tag()

    product_tag
  end
end
