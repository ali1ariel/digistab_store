defmodule DigistabStoreWeb.ProductLive.FormComponent do
  use DigistabStoreWeb, :live_component

  alias DigistabStore.Store
  alias DigistabStore.Repo
  alias DigistabStoreWeb.ProductLive.ProductTagsComponent

  def mount(socket), do: {:ok, socket}

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
      actual_category: (if (is_nil(product.category)), do: List.first(categories), else: product.category),
      ## tags
      tags: Store.list_tags(),
      selected_tags: [],
      tag_search_phrase: "",
      tag_search_results: [],
      show_all_tags: false,
    ]

    {:ok,
     socket
     |> assign(assigns)
     |> assign(new_assigns)}
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    IO.inspect product_params
    status =
      if product_params["status_select"] == "" do
        socket.assigns.actual_status
      else
        Enum.find(socket.assigns.status, &(&1.id == product_params["status_select"]))
      end

    category =
      if product_params["category_select"] == "" do
        socket.assigns.actual_category
      else
        Enum.find(socket.assigns.categories, &(&1.id == product_params["category_select"]))
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

  #### TAGS

  def handle_event("tag-search", %{"tag-name" => tag}, socket) do
    found_tags = search(socket.assigns.tags, tag)

    assigns = [
      tag_search_phrase: tag,
      tag_search_results: found_tags,
      show_all_tags: false,
      current_focus: -1
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("select-tag", %{"tag-id" => tag_id}, socket) do
    tag = socket.assigns.tags |> Enum.find(&(&1.id == tag_id))

    selected_tags = (socket.assigns.selected_tags ++ [tag]) |> sorted()

    send(
      self(),
      {__MODULE__, :update_selected_tags,
       %{selected_tags: selected_tags}}
    )

    assigns = [
      selected_tags: selected_tags,
      tags: (socket.assigns.tags -- [tag]) |> sorted(),
      tag_search_results: (socket.assigns.tag_search_results -- [tag]) |> sorted(),
      current_focus: -1
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("remove-tag", %{"tag-id" => tag_id}, socket) do
    tag = socket.assigns.selected_tags |> Enum.find(&(&1.id == tag_id))

    assigns = [
      selected_tags: (socket.assigns.selected_tags -- [tag]) |> sorted(),
      tags: (socket.assigns.tags ++ [tag]) |> sorted(),
      current_focus: -1
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("all-tags", %{}, socket) do

    assigns = [
      tag_search_phrase: "",
      tag_search_results: [],
      show_all_tags: !socket.assigns.show_all_tags,

    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("refresh-tags", %{}, socket) do
    tags = DigistabStore.Store.list_tags()

    assigns = [
      tag_search_phrase: "",
      tag_search_results: [],
      tags: tags -- socket.assigns.selected_tags,
    ]

    {:noreply, assign(socket, assigns)}
  end

  defp search(_, ""), do: []

  defp search(tags, tag_search_phrase) do
    IO.inspect tag_search_phrase
    tags
    |> Enum.filter(&matches?(&1.name, tag_search_phrase))
    |> sorted()
  end

  defp matches?(first, second) do
    String.contains?(
      String.downcase(first),
      String.downcase(second)
    )
  end

  def format_search_result(search_result, tag_search_phrase) do
    split_at = String.length(tag_search_phrase)
    {selected, rest} = String.split_at(search_result, split_at)

    "<strong>#{selected}</strong>#{rest}"
  end


  defp sorted(tags), do: Enum.sort_by(tags, &String.first(&1.name))


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
