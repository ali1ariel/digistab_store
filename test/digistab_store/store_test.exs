defmodule DigistabStore.StoreTest do
  use DigistabStore.DataCase

  alias DigistabStore.Store

  describe "products" do
    alias DigistabStore.Store.Product

    import DigistabStore.StoreFixtures

    @invalid_attrs %{description: nil, media: nil, name: nil, price: nil, quantity: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()

      assert Store.list_products() |> DigistabStore.Repo.preload([:status, :category]) == [
               product
             ]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()

      assert Store.get_product!(product.id) |> DigistabStore.Repo.preload([:status, :category]) ==
               product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{
        description: "some description",
        media: "some media",
        name: "some name",
        price: 42,
        quantity: 42
      }

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

      update_attrs = %{
        description: "some updated description",
        media: "some updated media",
        name: "some updated name",
        price: 43,
        quantity: 43
      }

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

      assert product ==
               Store.get_product!(product.id) |> DigistabStore.Repo.preload([:status, :category])
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Store.delete_product(product)

      assert_raise Ecto.NoResultsError, fn ->
        Store.get_product!(product.id) |> DigistabStore.Repo.preload([:status, :category])
      end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Store.change_product(product)
    end
  end

  describe "status" do
    alias DigistabStore.Store.Status

    import DigistabStore.StoreFixtures

    @invalid_attrs %{description: nil, id: nil, name: nil}

    test "list_status/0 returns all status" do
      status = status_fixture()
      assert Store.list_status() == [status]
    end

    test "get_status!/1 returns the status with given id" do
      status = status_fixture()
      assert Store.get_status!(status.id) == status
    end

    test "create_status/1 with valid data creates a status" do
      valid_attrs = %{
        description: "some description",
        name: "some name"
      }

      assert {:ok, %Status{} = status} = Store.create_status(valid_attrs)
      assert status.description == "some description"
      assert status.name == "some name"
    end

    test "create_status/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_status(@invalid_attrs)
    end

    test "update_status/2 with valid data updates the status" do
      status = status_fixture()

      update_attrs = %{
        description: "some updated description",
        name: "some updated name"
      }

      assert {:ok, %Status{} = status} = Store.update_status(status, update_attrs)
      assert status.description == "some updated description"
      assert status.name == "some updated name"
    end

    test "update_status/2 with invalid data returns error changeset" do
      status = status_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_status(status, @invalid_attrs)
      assert status == Store.get_status!(status.id)
    end

    test "delete_status/1 deletes the status" do
      status = status_fixture()
      assert {:ok, %Status{}} = Store.delete_status(status)
      assert_raise Ecto.NoResultsError, fn -> Store.get_status!(status.id) end
    end

    test "change_status/1 returns a status changeset" do
      status = status_fixture()
      assert %Ecto.Changeset{} = Store.change_status(status)
    end
  end

  describe "categories" do
    alias DigistabStore.Store.Category

    import DigistabStore.StoreFixtures

    @invalid_attrs %{description: nil, id: nil, name: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Store.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Store.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{
        description: "some description",
        id: "7488a646-e31f-11e4-aace-600308960662",
        name: "some name"
      }

      assert {:ok, %Category{} = category} = Store.create_category(valid_attrs)
      assert category.description == "some description"
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()

      update_attrs = %{
        description: "some updated description",
        id: "7488a646-e31f-11e4-aace-600308960668",
        name: "some updated name"
      }

      assert {:ok, %Category{} = category} = Store.update_category(category, update_attrs)
      assert category.description == "some updated description"
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_category(category, @invalid_attrs)
      assert category == Store.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Store.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Store.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Store.change_category(category)
    end
  end

  describe "tags" do
    alias DigistabStore.Store.Tag

    import DigistabStore.StoreFixtures

    @invalid_attrs %{description: nil, id: nil, name: nil}

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Store.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Store.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      valid_attrs = %{
        description: "some description",
        id: "7488a646-e31f-11e4-aace-600308960662",
        name: "some name"
      }

      assert {:ok, %Tag{} = tag} = Store.create_tag(valid_attrs)
      assert tag.description == "some description"
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()

      update_attrs = %{
        description: "some updated description",
        id: "7488a646-e31f-11e4-aace-600308960668",
        name: "some updated name"
      }

      assert {:ok, %Tag{} = tag} = Store.update_tag(tag, update_attrs)
      assert tag.description == "some updated description"
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_tag(tag, @invalid_attrs)
      assert tag == Store.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Store.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Store.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Store.change_tag(tag)
    end
  end
end
