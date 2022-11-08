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
    schedule_end = ~N[2022-11-05 02:00:00]
    schedule_start = ~N[2022-11-04 22:00:00]
    with {:ok, last} <- Clock.get_last_clock_by_user(%{user_id: user_id}),
         {:check_status, true, _x} <- {:check_status, status != last.status, last.status},
         {:ok, %Clock{} = clock} <- Clock.create(%{user_id: user_id, time: NaiveDateTime.utc_now(), status: status}),
         {:is_clock_out, true} <- {:is_clock_out, !status},
         result <- Clock.get_hours(%{clock_in: ~N[2022-11-04 23:00:00], clock_out: ~N[2022-11-05 05:00:00], schedule_end: schedule_end, schedule_start: schedule_start}),
        #  do conn |> render("message.json", message: result)
         {:ok, %HoursWorked{} = hours_worked} <- HoursWorked.create_hours_worked(%{
              date: NaiveDateTime.utc_now(),
              normal_hours: result.normal_hours,
              night_hours: result.night_hours,
              overtime_hours: result.overtime,
              # night_overtime: night_overtime,
              expected_worked_hours: NaiveDateTime.diff(schedule_end, schedule_start, :minute) / 60,
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

      {:is_clock_out, false} -> conn |> put_status(200) |> render("message.json", message: "You have successfully clocked in")
    end
  end
end
