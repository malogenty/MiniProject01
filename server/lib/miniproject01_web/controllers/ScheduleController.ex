defmodule ApiProjectWeb.ScheduleController do
  require Logger
  use ApiProjectWeb, :controller
  alias ApiProject.{Schedule, HoursWorked}

  action_fallback(ApiProjectWeb.FallbackController)

  def list(conn, params) do
    if params["start"] && params["end"] do
      schedules =
        Schedule.get_by_time(%{
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

  def create(conn, %{
        "userId" => user_id,
        "schedule" => schedule_params
      }) do
    {:ok, st_date} = NaiveDateTime.from_iso8601(schedule_params["start"])

    
    if st_date.hour + schedule_params["duration"] / 60 <= 24 do
      cond do
        schedule_params["title"] == "work" ->
          user_schedule = Map.put(schedule_params, "user_id", user_id)
          with {:ok, %Schedule{} = schedule} <- Schedule.create(user_schedule) do
            duration_hours = schedule_params["duration"] / 60
            with {:ok, hours} <- HoursWorked.get_hours_workeds_by_day(%{userId: user_id, date: NaiveDateTime.to_date(st_date)}) do
              HoursWorked.update_hours_worked(%{user_id: user_id, date: NaiveDateTime.to_date(st_date), expected_worked_hours: duration_hours})
              render(conn, "schedule.json", schedule: schedule)       
            else {:not_found, reason, status} -> 
              HoursWorked.create_hours_worked(%{user_id: user_id, date: NaiveDateTime.to_date(st_date), expected_worked_hours: duration_hours})
              json(conn, %{status: reason})
            end
          else {:error, %Ecto.Changeset{}} -> json(conn, %{error: "unable to create"})

          end
      end

      # not same day ! needs to check time before && after midnight
    else
      {:ok, st_midnight} =
        NaiveDateTime.new(st_date.year, st_date.month, st_date.day, 23, 59, 59, 999)

      day_1_hours = round(abs(NaiveDateTime.diff(st_date, st_midnight, :second) / 60 / 60))
      day_2_hours = schedule_params["duration"] / 60 - day_1_hours

      cond do
        day_2_hours < 24 ->
          json(conn, %{day1: day_1_hours, day2: day_2_hours})

        true ->
          send_resp(conn, 401, "Too Long")
      end
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
