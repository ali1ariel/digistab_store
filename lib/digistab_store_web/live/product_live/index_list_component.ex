defmodule DigistabStoreWeb.ProductLive.Index.IndexListComponent do
  use DigistabStoreWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{products: products, id: id}, socket) do
    assigns = [
      products: products |> sort_by_name(true),
      id: id,
      sort_by: "name",
      sort_type: true,
      marked_products: []
    ]

    {:ok, socket |> assign(assigns)}
  end

  def handle_event("sort-by", %{"type" => type}, socket) do
    assigns =
      if(socket.assigns.sort_by == type) do
        [
        sort_by: type,
        sort_type: !socket.assigns.sort_type,
        products: sort(socket.assigns.products, type, !socket.assigns.sort_type)
        ]
      else
        [
          sort_by: type,
          sort_type: true,
          products: sort(socket.assigns.products, type, true)
        ]
      end
    {:noreply, socket |> assign(assigns)}
  end

  def handle_event("mark-product", %{"product-id" => id}, socket) do
    IO.inspect(id)

    marked_products = socket.assigns.marked_products
    marked_products = if id in marked_products do
      marked_products -- [id]
    else
      marked_products ++ [id]
    end

    {:noreply, socket |> assign(marked_products: marked_products)}
  end

  def sort(products, type, sort) do
    case type do
      "name" -> sort_by_name(products, sort)
      "status" -> sort_by_status(products, sort)
      "category" -> sort_by_category(products, sort)
    end
  end

  def sort_by_name(products, sort) do
    sort = if sort, do: :asc, else: :desc
    products |> Enum.sort_by(&{String.first(&1.name), byte_size(&1.name)}, sort)
  end


  def sort_by_status(products, sort) do
    sort = if sort, do: :asc, else: :desc
    products |> Enum.sort_by(&{String.first(&1.status.name), byte_size(&1.status.name)}, sort)
  end

  def sort_by_category(products, sort) do
    sort = if sort, do: :asc, else: :desc
    products |> Enum.sort_by(&{String.first(&1.category.name), byte_size(&1.category.name)}, sort)
  end

  def sort_icon(field, sort_by, sort_type) do
    # IO.inspect(socket.assigns)
    if sort_by == field do
      if sort_type do
        raw(~s[<i class="fa-solid fa-sort-down"></i>])
      else
        raw(~s[<i class="fa-solid fa-sort-up"></i>])
      end
    else
      raw(~s[<i class="fa-solid fa-sort"></i>])
    end
  end
end
