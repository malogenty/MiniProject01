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

  def create(conn, %{"userId" => user_id, "status" => status}) do
    with {:ok, clock} <- Clock.get_last_clock_by_user(%{user_id: user_id}),
         {true, _x} <- {status != clock.status, clock.status},
         {:ok, %Clock{} = clock} <-
           Clock.create(%{user_id: user_id, time: NaiveDateTime.utc_now(), status: status}) do
      conn |> put_status(201) |> render("clock.json", clock: clock)
    else
      :error ->
        conn
        |> put_status(400)
        |> render("error.json", reason: "The payload does not match the expected pattern")

      {:not_found, reason, status} ->
        conn |> put_status(status) |> render("error.json", reason: reason)

      {false, false} ->
        conn |> put_status(400) |> render("error.json", reason: "You already clocked out")

      {false, true} ->
        conn |> put_status(400) |> render("error.json", reason: "You already clocked in")
    end
  end
end
