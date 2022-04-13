defmodule DigistabStoreWeb.PageController do
  use DigistabStoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
