defmodule ApiProjectWeb.ClockController do
  use ApiProjectWeb, :controller
  alias ApiProject.Clock
  alias ApiProject.HoursWorked

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
         {:check_status, true, _x} <- {:check_status, status != clock.status, clock.status},
         {:ok, %Clock{} = clock} <- Clock.create(%{user_id: user_id, time: NaiveDateTime.utc_now(), status: status}),
         {:is_clock_out, true} <- {:is_clock_out, !status},
         {:ok, %HoursWorked{} = hours_worked} <- HoursWorked.create_hours_worked(%{
              date: "2022-11-02 00:00:00",
              normal_hours: 6.00,
              night_hours: 1.00,
              overtime_hours: 0.00,
              expected_worked_hours: 7.5,
              user_id: user_id
          }) do
          conn |> put_status(201) |> render("hours_worked.json", hours_worked: hours_worked)
    else
      :error ->
        conn
        |> put_status(400)
        |> render("error.json", reason: "The payload does not match the expected pattern")

      {:not_found, reason, status} ->
        conn |> put_status(status) |> render("error.json", reason: reason)

      {:check_status, false, false} ->
        conn |> put_status(400) |> render("error.json", reason: "You already clocked out")

      {:check_status, false, true} ->
        conn |> put_status(400) |> render("error.json", reason: "You already clocked in")

      {:is_clock_out, false} -> conn |> put_status(400) |> render("message.json", message: "You have successfully clocked in")
    end
  end
end
