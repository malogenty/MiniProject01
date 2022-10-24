defmodule Miniproject01Web.UserController do
  use Miniproject01Web, :controller

  def index(conn, _params, %{"userId" => id}) do
    json(conn, %{hello: "index"})
  end

  def create(conn) do
    json(conn, %{hello: "create"})
  end

  def update(conn, %{"userId" => id}) do
    json(conn, %{hello: "update"})
  end

  def delete(conn, %{"userId" => id}) do
    json(conn, %{hello: "delete"})
  end
end
