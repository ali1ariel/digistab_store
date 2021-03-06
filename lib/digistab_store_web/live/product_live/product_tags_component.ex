defmodule DigistabStoreWeb.ProductLive.ProductTagsComponent do
  use DigistabStoreWeb, :live_component

  def update(
        %{
          id: id,
          selected_tags: selected_tags,
          form_target: form_target,
          tags: tags,
          tag_search_phrase: tag_search_phrase,
          tag_search_results: tag_search_results,
          show_all_tags: show_all_tags
        },
        socket
      ) do
    assigns = [
      id: id,
      selected_tags: selected_tags,
      form_target: form_target,
      tags: tags,
      tag_search_phrase: tag_search_phrase,
      tag_search_results: tag_search_results,
      show_all_tags: show_all_tags
    ]

    {:ok, assign(socket, assigns)}
  end
end
