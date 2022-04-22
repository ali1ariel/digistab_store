defmodule DigistabStoreWeb.ProductLive.Index.IndexGridComponent do
  use DigistabStoreWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{products: products, id: id}, socket) do
    assigns = [
      products: products,
      id: id
    ]

    {:ok, socket |> assign(assigns)}
  end

  defp active?(product) do
    if product.status.name == "Ativo" do
      ~s[]
    else
      ~s[opacity-50]
    end
  end
end
