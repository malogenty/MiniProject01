defmodule ApiProjectWeb.ScheduleController do
  use ApiProjectWeb, :controller
  alias ApiProject.Schedule
  alias ApiProject.HoursWorked

  action_fallback(ApiProjectWeb.FallbackController)

  def list(conn, params) do
    if params["start"] && params["end"] do
      schedules = Schedule.get_by_time(%{
        user_id: params["userId"],
        start: params["start"],
        end: params["end"]
      })
      render(conn, "list.json", schedules: schedules)
    else
      schedules = Schedule.get_by_user(%{user_id: params["userId"]})
      render(conn, "list.json", schedules: schedules)
    end
  end

  def create(conn, %{"userId" => user_id, "title" => title, "start" => start_datetime, "end" => end_datetime}) do
    with {:ok, %Schedule{} = schedule} <-
      Schedule.create(
        %{"user_id" => user_id, "title" => title, "start" => start_datetime, "end" => end_datetime}
      ) do
      hours_workeds = HoursWorked.get_hours_workeds_by_day(%{"userId" => user_id, "start" => start_datetime, "end" => end_datetime})
      case hours_workeds do
        hours_workeds -> {for hour <- hours_workeds do
          HoursWorked.update_hours_worked(hour, %{"expected_worked_hours" => DateTime.diff(start_datetime, end_datetime)})
        end}
        nil -> {HoursWorked.create_hours_worked(%{"user_id" => user_id, "date" => Ecto.DateTime.cast(start_datetime).day, "expected_worked_hours" => DateTime.diff(start_datetime, end_datetime)})}
      end
      conn
      |> render("schedule.json", schedule: schedule)
    end
  end

  def update(conn, %{"id" => id, "schedule" => schedule_params}) do
    schedule = Schedule.get(id)
    with {:ok, %Schedule{} = schedule} <-
        Schedule.update(schedule, schedule_params) do
      render(conn, "schedule.json", schedule: schedule)
    end
  end

  def delete(conn, %{"id" => id}) do
    schedule = Schedule.get(id)
    with {:ok, %Schedule{}} <- Schedule.delete(schedule) do
      send_resp(conn, :no_content, "")
    end
  end

end
