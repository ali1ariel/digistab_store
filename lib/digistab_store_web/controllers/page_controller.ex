defmodule DigistabStoreWeb.PageController do
  use DigistabStoreWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/products")
  end
end
