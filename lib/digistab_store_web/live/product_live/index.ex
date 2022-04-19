defmodule DigistabStoreWeb.ProductLive.Index do
  use DigistabStoreWeb, :live_view

  alias DigistabStore.Store
  alias DigistabStore.Store.Product
  alias DigistabStore.Repo

  @impl true
  def mount(_params, _session, socket) do
    assigns = [
      products:
        list_products()
        |> DigistabStore.Repo.preload([:status, :category, :tags]),
      status_collection: Store.list_status(),
      status: nil,
      categories: Store.list_categories(),
      category: nil
    ]

    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, Store.get_product!(id) |> Repo.preload(:status))
  end

  defp apply_action(socket, :new, _params) do
    assigns = [
      product: %Product{}
    ]

    socket
    |> assign(:page_title, "New Product")
    |> assign(assigns)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:product, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product = Store.get_product!(id) |> Repo.preload(:status)
    {:ok, _} = Store.delete_product(product)

    {:noreply, assign(socket, :products, list_products())}
  end

  @impl true
  def handle_event("set-status", %{"status" => id}, socket) do
    status = socket.assigns.status_collection |> Enum.find(&(&1.id == id))
    category = socket.assigns.category

    products =
      list_products()
      |> DigistabStore.Repo.preload([:status, :category, :tags])
      |> then(
        &if is_nil(category),
          do: &1,
          else: Enum.filter(&1, fn product -> product.category_id == category.id end)
      )
      |> Enum.filter(fn product -> product.status_id == id end)

    {:noreply, assign(socket, products: products, status: status)}
  end

  @impl true
  def handle_event("set-status", %{}, socket) do
    category = socket.assigns.category

    products =
      list_products()
      |> DigistabStore.Repo.preload([:status, :category, :tags])
      |> then(
        &if is_nil(category),
          do: &1,
          else: Enum.filter(&1, fn product -> product.category_id == category.id end)
      )

    {:noreply, assign(socket, products: products, status: nil)}
  end

  @impl true
  def handle_event("set-category", %{"category" => id}, socket) do
    category = socket.assigns.categories |> Enum.find(&(&1.id == id))
    status = socket.assigns.status

    products =
      list_products()
      |> DigistabStore.Repo.preload([:status, :category, :tags])
      |> then(
        &if is_nil(status),
          do: &1,
          else: Enum.filter(&1, fn product -> product.status_id == status.id end)
      )
      |> Enum.filter(fn product -> product.category_id == id end)

    {:noreply, assign(socket, products: products, category: category)}
  end

  @impl true
  def handle_event("set-category", %{}, socket) do
    status = socket.assigns.status

    products =
      list_products()
      |> DigistabStore.Repo.preload([:status, :category, :tags])
      |> then(
        &if is_nil(status),
          do: &1,
          else: Enum.filter(&1, fn product -> product.status_id == status.id end)
      )

    {:noreply, assign(socket, products: products, category: nil)}
  end

  defp list_products do
    Store.list_products()
  end

  defp active?(product) do
    if product.status.name == "Ativo" do
      ~s[]
    else
      ~s[opacity-30]
    end
  end
end
