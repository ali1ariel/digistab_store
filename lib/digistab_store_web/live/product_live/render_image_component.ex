defmodule DigistabStoreWeb.ProductLive.RenderImageComponent do
  use DigistabStoreWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{media: media, id: id}, socket) do
    assigns = [
      media: media,
      id: id,
      current_position: 0
    ]

    {:ok, socket |> assign(assigns)}
  end

  def handle_event("next-image", _, socket) do
    assigns = [
      current_position: socket.assigns.current_position + 1
    ]
    {:noreply, socket |> assign(assigns)}
  end

  def handle_event("previous-image", _, socket) do
    assigns = [
      current_position: socket.assigns.current_position - 1
    ]
    {:noreply, socket |> assign(assigns)}
  end
end
