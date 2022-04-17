defmodule DigistabStoreWeb.ProductLive.Index do
  use DigistabStoreWeb, :live_view

  alias DigistabStore.Store
  alias DigistabStore.Store.Product
  alias DigistabStore.Repo

  @impl true
  def mount(_params, _session, socket) do
    assigns = [
      products: list_products()
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



  defp list_products do
    Store.list_products()
  end
end
