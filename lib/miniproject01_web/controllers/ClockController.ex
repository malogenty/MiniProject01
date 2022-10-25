defmodule ApiProjectWeb.ClockController do
  use ApiProjectWeb, :controller
  alias ApiProject.Clock
  
  def read(conn, %{"userId" => userId}) do
    clocks = Clock.select(userId)
    if clocks do
      render(conn, "clocks.json", clocks: clocks)
    else
      conn
      |> put_status(404)
      |> render("error.json", "Couln't find the user")
    end
  end
  def create(conn, %{"userId" => userId}) do
    with {:ok, %Clock{} = clock} <- Clock.create(%{user: userId, time: NaiveDateTime.utc_now, status: true}) do
      render(conn, "clock.json", clock: clock)
    else
      :error ->
        conn
        |> put_status(400)
        |> render("error.json", reason: "The payload does not match the expected pattern")
    end
  end
end