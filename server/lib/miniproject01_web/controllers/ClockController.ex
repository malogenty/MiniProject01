defmodule ApiProjectWeb.ClockController do
  use ApiProjectWeb, :controller
  alias ApiProject.Clock

  action_fallback(ApiProjectWeb.FallbackController)

  def read(conn, %{"userId" => user_id}) do
    clocks = Clock.get_clocks_by_user(%{user_id: user_id})

    if clocks do
      render(conn, "clocks.json", clocks: clocks)
    else
      conn
      |> put_status(404)
      |> render("error.json", "Couln't find the user")
    end
  end

  def create(conn, %{"userId" => userId, "status" => status}) do
    with {:ok, %Clock{} = clock} <-
           Clock.create(%{user_id: userId, time: NaiveDateTime.utc_now(), status: status}) do
      render(conn, "clock.json", clock: clock)
    else
      :error ->
        conn
        |> put_status(400)
        |> render("error.json", reason: "The payload does not match the expected pattern")
    end
  end
end
