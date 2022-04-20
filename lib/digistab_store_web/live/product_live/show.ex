defmodule DigistabStoreWeb.ProductLive.Show do
  use DigistabStoreWeb, :live_view

  alias DigistabStore.Store
  alias DigistabStore.Repo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product, Store.get_product!(id) |> Repo.preload([:status, :category, :tags]))}
  end

  defp page_title(:show), do: "Exibindo Produto"
  defp page_title(:edit), do: "Editando Produto"
end
