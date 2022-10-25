defmodule ApiProjectWeb.ClockController do
  use ApiProjectWeb, :controller
  def read(conn, _params) do
    json(conn, %{id: "qsd"})
  end    
end