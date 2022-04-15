defmodule DigistabStoreWeb.ProductLive.FormComponent do
  use DigistabStoreWeb, :live_component

  alias DigistabStore.Store
  alias DigistabStore.Repo

  @impl true
  def update(%{product: product} = assigns, socket) do
    product = product |> Repo.preload(:status)

    status = DigistabStore.Store.list_status()

    new_assigns = [
      changeset: Store.change_product(product),
      status: status,
      actual_status: if(is_nil(product.status), do: List.first(status), else: product.status)
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

    changeset =
      socket.assigns.product
      |> Repo.preload(:status)
      |> Store.change_product(product_params |> Map.put("status", status))
      |> Map.put(:action, :validate)

    assigns = [
      changeset: changeset,
      actual_status: status
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  defp save_product(socket, :edit, product_params) do
    status = DigistabStore.Store.get_status!(product_params["status_select"])
    params = product_params |> Map.put("status", status)

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
    params = product_params |> Map.put("status", status)

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
