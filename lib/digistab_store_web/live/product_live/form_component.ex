defmodule DigistabStoreWeb.ProductLive.FormComponent do
  use DigistabStoreWeb, :live_component

  alias DigistabStore.Store
  alias DigistabStore.Repo

  @impl true
  def update(%{product: product} = assigns, socket) do
    product = product |> Repo.preload([:status, :category])

    status = DigistabStore.Store.list_status()
    categories = DigistabStore.Store.list_categories()

    new_assigns = [
      changeset: Store.change_product(product),
      status: status,
      actual_status: (if (is_nil(product.status)), do: List.first(status), else: product.status),
      categories: categories,
      actual_category: (if (is_nil(product.category)), do: List.first(categories), else: product.category)
    ]

    {:ok,
     socket
     |> assign(assigns)
     |> assign(new_assigns)}
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    status =
      if product_params["status_select"] == "" do
        socket.assigns.actual_status
      else
        DigistabStore.Store.get_status!(product_params["status_select"])
      end

    category =
      if product_params["category_select"] == "" do
        socket.assigns.actual_category
      else
        DigistabStore.Store.get_category!(product_params["category_select"])
      end

    changeset =
      socket.assigns.product
      |> Repo.preload([:status, :category])
      |> Store.change_product(product_params |> Map.put("status", status) |> Map.put("category", category))
      |> Map.put(:action, :validate)

    assigns = [
      changeset: changeset,
      actual_status: status,
      actual_category: category
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  defp save_product(socket, :edit, product_params) do
    status = DigistabStore.Store.get_status!(product_params["status_select"])
    category = DigistabStore.Store.get_category!(product_params["category_select"])
    params = product_params |> Map.put("status", status) |> Map.put("category", category)

    case Store.update_product(socket.assigns.product |> Repo.preload(:status), params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product(socket, :new, product_params) do
    status = DigistabStore.Store.get_status!(product_params["status_select"])
    category = DigistabStore.Store.get_category!(product_params["category_select"])
    params = product_params |> Map.put("status", status) |> Map.put("category", category)

    case Store.create_product(params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
