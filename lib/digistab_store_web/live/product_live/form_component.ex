defmodule DigistabStoreWeb.ProductLive.FormComponent do
  use DigistabStoreWeb, :live_component

  alias DigistabStore.Store
  alias DigistabStore.Store.Product
  alias DigistabStore.Repo
  alias DigistabStoreWeb.ProductLive.ProductTagsComponent

  @impl true
  def mount(socket) do
    {:ok,
     socket
     |> allow_upload(:media, accept: ~w[.jpg .jpeg .png], max_entries: 1)}
  end

  @impl true
  def update(%{product: product} = assigns, socket) do
    product = product |> Repo.preload([:status, :category, :tags])

    status = DigistabStore.Store.list_status()
    categories = DigistabStore.Store.list_categories()

    selected_tags = product.tags

    new_assigns = [
      changeset: Store.change_product(product),
      status: status,
      actual_status:
        if is_nil(product.status) do
          List.first(status)
        else
          product.status
        end,
      categories: categories,
      actual_category:
        if(is_nil(product.category), do: List.first(categories), else: product.category),
      ## tags
      tags: Store.list_tags() -- selected_tags,
      selected_tags: selected_tags,
      tag_search_phrase: "",
      tag_search_results: [],
      show_all_tags: false,
      display_media_field: false
    ]

    {:ok,
     socket
     |> assign(assigns)
     |> assign(new_assigns)}
  end

  @impl true
  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
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
      |> Store.change_product(
        product_params
        |> Map.put("status", status)
        |> Map.put("category", category)
      )
      |> Map.put(:action, :validate)

    assigns = [
      changeset: changeset,
      actual_status: status,
      actual_category: category
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("media-field", %{}, socket) do
    case socket.assigns.uploads.media.entries |> List.first() do
      nil ->
        {:noreply, socket |> assign(display_media_field: !socket.assigns.display_media_field)}

      entry ->
        {:noreply,
         socket
         |> assign(display_media_field: !socket.assigns.display_media_field)
         |> cancel_upload(:media, entry.ref)}
    end
  end

  def handle_event("cancel-entry", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :media, ref)}
  end

  ######## TAGS
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
      {__MODULE__, :update_selected_tags, %{selected_tags: selected_tags}}
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
      show_all_tags: !socket.assigns.show_all_tags
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("refresh-tags", %{}, socket) do
    tags = DigistabStore.Store.list_tags()

    assigns = [
      tag_search_phrase: "",
      tag_search_results: [],
      tags: tags -- socket.assigns.selected_tags
    ]

    {:noreply, assign(socket, assigns)}
  end

  defp search(_, ""), do: []

  defp search(tags, tag_search_phrase) do
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
    product = socket.assigns.product |> Repo.preload([:status, :category])

    media =
      if product_params["media"] in [product.media, ""],
        do: consume_upload(socket, product_params["media"]),
        else: product_params["media"]

    params = set_product_params(product_params, media)

    tags = socket.assigns.selected_tags

    case Store.update_product(product, params) do
      {:ok, product} ->
        handle_tags(product, tags)

        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product(socket, :new, product_params) do
    media =
      if !Map.has_key?(product_params, "media"),
        do: consume_upload(socket, product_params["media"]),
        else: product_params["media"]

    params = set_product_params(product_params, media)

    if media in ["", nil] do
      {:noreply,
       socket
       |> put_flash(:error, "Por favor, insira um arquivo de imagem ou um link.")}
    else
      tags = socket.assigns.selected_tags

      case Store.create_product(%Product{}, params) do
        {:ok, product} ->
          handle_tags(product, tags)

          {:noreply,
           socket
           |> put_flash(:info, "Product created successfully")
           |> push_redirect(to: socket.assigns.return_to)}

        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, changeset: changeset)}
      end
    end
  end

  defp set_product_params(product_params, media) do
    status = DigistabStore.Store.get_status!(product_params["status_select"])
    category = DigistabStore.Store.get_category!(product_params["category_select"])

    product_params
    |> Map.put("status", status)
    |> Map.put("category", category)
    |> Map.put("media", media)
  end

  defp ext(entry) do
    [ext | _] = MIME.extensions(entry.client_type)
    ext
  end

  defp consume_upload(socket, media) do
    case consume_uploaded_entries(socket, :media, fn %{path: path}, entry ->
           dest =
             Path.join([
               :code.priv_dir(:digistab_store),
               "static",
               "uploads",
               "#{entry.uuid}.#{ext(entry)}"
             ])

           File.cp!(path, dest)

           {:ok, Routes.static_path(socket, "/uploads/#{Path.basename(dest)}")}
         end) do
      [] -> media
      [new_media] -> new_media
    end
  end

  defp handle_tags(product, tags) do
    product = product |> Repo.preload([:tags])
    tags_in_product = product.tags
    tags_to_add = tags -- tags_in_product
    tags_to_remove = tags_in_product -- tags

    Enum.map(tags_to_add, &Store.assoc_product_tag(product, &1))
    Enum.map(tags_to_remove, &Store.dissoc_product_tag(product, &1))
  end
end
