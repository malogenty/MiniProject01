defmodule ApiProjectWeb.ClockController do
  use ApiProjectWeb, :controller

  def read(conn, %{"user" => user}) do
    json(conn, %{id: user})
  end

  def post(conn, %{"user" => user}) do
    json(conn, %{id: user})
  end
end
