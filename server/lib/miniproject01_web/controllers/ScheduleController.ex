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

  # Helper method
  def update_expected_hours(%{user_id: user_id, expected_hours: expected_hours, date: date}) do
    with {:ok, hours} <-
           HoursWorked.get_hours_workeds_by_day(%{userId: user_id, date: date}) do
      with {:ok, updated} <-
             HoursWorked.update_hours_worked(hours, %{expected_worked_hours: expected_hours}) do
        %{updated: %{id: updated.id, expected: updated.expected_worked_hours}}
      else
        {:error, %Ecto.Changeset{}} -> %{error: "unable to update"}
      end
    else
      {:not_found, reason, status} ->
        with {:ok, %HoursWorked{} = hours} <-
               HoursWorked.create_hours_worked(%{
                 user_id: user_id,
                 date: date,
                 expected_worked_hours: expected_hours
               }) do
          %{created: %{id: hours.id, expected: hours.expected_worked_hours}}
        end
    end
  end

  def create(conn, %{
        "userId" => user_id,
        "schedule" => schedule_params
      }) do
    {:ok, st_date_hour} = NaiveDateTime.from_iso8601(schedule_params["start"])
    day_1 = NaiveDateTime.to_date(st_date_hour)

    if schedule_params["title"] == "work" do
      user_schedule = Map.put(schedule_params, "user_id", user_id)

      with {:ok, %Schedule{} = schedule} <- Schedule.create(user_schedule) do
        if st_date_hour.hour + schedule_params["duration"] / 60 <= 24 do
          duration_hours = schedule_params["duration"] / 60

          res =
            update_expected_hours(%{user_id: user_id, expected_hours: duration_hours, date: day_1})

          json(conn, res)

          # not same day ! needs to check time before && after midnight
        else
          {:ok, st_midnight} =
            NaiveDateTime.new(day_1.year, day_1.month, day_1.day, 23, 59, 59, 999)

          day_1_hours =
            round(abs(NaiveDateTime.diff(st_date_hour, st_midnight, :second) / 60 / 60))

          day_2_hours = schedule_params["duration"] / 60 - day_1_hours

          cond do
            day_2_hours < 24 ->
              day_1_res =
                update_expected_hours(%{
                  user_id: user_id,
                  expected_hours: day_1_hours,
                  date: day_1
                })

              day_2_res =
                update_expected_hours(%{
                  user_id: user_id,
                  expected_hours: day_2_hours,
                  date: Date.add(day_1, 1)
                })

              json(conn, %{
                day_1: day_1_res,
                day_2: day_2_res,
                schedule: %{id: schedule.id, duration: schedule.duration}
              })

            true ->
              send_resp(conn, 401, "Too Long")
          end
        end
      else
        {:error, %Ecto.Changeset{}} -> json(conn, %{error: "unable to create"})
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
