defmodule DigistabStore.StoreTest do
  use DigistabStore.DataCase

  alias DigistabStore.Store

  describe "products" do
    alias DigistabStore.Store.Product

    import DigistabStore.StoreFixtures

    @invalid_attrs %{description: nil, media: nil, name: nil, price: nil, quantity: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Store.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Store.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{description: "some description", media: "some media", name: "some name", price: 42, quantity: 42}

      assert {:ok, %Product{} = product} = Store.create_product(valid_attrs)
      assert product.description == "some description"
      assert product.media == "some media"
      assert product.name == "some name"
      assert product.price == 42
      assert product.quantity == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{description: "some updated description", media: "some updated media", name: "some updated name", price: 43, quantity: 43}

      assert {:ok, %Product{} = product} = Store.update_product(product, update_attrs)
      assert product.description == "some updated description"
      assert product.media == "some updated media"
      assert product.name == "some updated name"
      assert product.price == 43
      assert product.quantity == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_product(product, @invalid_attrs)
      assert product == Store.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Store.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Store.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Store.change_product(product)
    end
  end
end
