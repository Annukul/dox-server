defmodule DoxServerWeb.PageController do
  use DoxServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
