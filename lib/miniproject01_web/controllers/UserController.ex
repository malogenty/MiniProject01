defmodule Miniproject01Web.UserController do
  use Miniproject01Web, :controller

  def index(conn, _params) do
    json(conn, %{hello: "index"})
  end

  def create(conn, _params) do
    json(conn, %{hello: "create"})
  end

  def update(conn, _params) do
    json(conn, %{hello: "update"})
  end

  def delete(conn, _params) do
    json(conn, %{hello: "delete"})
  end
end
