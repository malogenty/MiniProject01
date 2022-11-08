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
             HoursWorked.update_hours_worked(hours, %{
               expected_worked_hours: hours.expected_worked_hours + expected_hours
             }) do
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

  def update_one_or_two_days_exp_hours(%{
        start: start_datetime,
        duration: duration,
        user_id: user_id,
        delete: delete
      }) do
    date = NaiveDateTime.to_date(start_datetime)

    if start_datetime.hour + duration / 60 <= 24 do
      duration_hours = duration / 60

      if(!delete) do
        update_expected_hours(%{user_id: user_id, expected_hours: duration_hours, date: date})
      else
        update_expected_hours(%{user_id: user_id, expected_hours: 0, date: date})
      end

      # not same day ! needs to check time before && after midnight
    else
      {:ok, st_midnight} = NaiveDateTime.new(date.year, date.month, date.day, 23, 59, 59, 999)

      day_1_hours = round(abs(NaiveDateTime.diff(start_datetime, st_midnight, :second) / 60 / 60))

      day_2_hours = duration / 60 - day_1_hours

      cond do
        day_2_hours < 24 ->
          if(!delete) do
            day_1_res =
              update_expected_hours(%{
                user_id: user_id,
                expected_hours: day_1_hours,
                date: date
              })

            day_2_res =
              update_expected_hours(%{
                user_id: user_id,
                expected_hours: day_2_hours,
                date: Date.add(date, 1)
              })

            %{
              day_1: day_1_res,
              day_2: day_2_res
            }
          else
            day_1_res =
              update_expected_hours(%{
                user_id: user_id,
                expected_hours: 0,
                date: date
              })

            day_2_res =
              update_expected_hours(%{
                user_id: user_id,
                expected_hours: 0,
                date: Date.add(date, 1)
              })

            %{
              day_1: day_1_res,
              day_2: day_2_res
            }
          end

        true ->
          %{error: "Too long"}
      end
    end
  end

  def create(conn, %{
        "userId" => user_id,
        "schedule" => schedule_params
      }) do
    {:ok, start_datetime} = NaiveDateTime.from_iso8601(schedule_params["start"])
    user_schedule = Map.put(schedule_params, "user_id", user_id)

    with {:ok, %Schedule{} = schedule} <- Schedule.create(user_schedule) do
      if schedule_params["title"] == "work" do
        update_one_or_two_days_exp_hours(%{
          start: start_datetime,
          duration: schedule_params["duration"],
          user_id: user_id,
          delete: false
        })

        render(conn, "schedule.json", schedule: schedule)
      else
        render(conn, "schedule.json", schedule: schedule)
      end
    end
  end

  def update(conn, %{"id" => id, "schedule" => schedule_params}) do
    schedule = Schedule.get(id)

    # from x to work
    if (schedule.title == :work && is_nil(schedule_params["title"])) ||
         schedule_params["title"] == "work" do
      {:ok, start_datetime} =
        if !is_nil(schedule_params["start"]) do
          NaiveDateTime.from_iso8601!(schedule_params["start"])
        else
          {:ok, schedule.start}
        end

      duration = schedule_params["duration"] || schedule.duration

      update_one_or_two_days_exp_hours(%{
        start: schedule.start,
        duration: schedule.duration,
        user_id: schedule.user_id,
        delete: true
      })

      update_one_or_two_days_exp_hours(%{
        start: start_datetime,
        duration: duration,
        user_id: schedule.user_id,
        delete: false
      })

      with {:ok, schedule} <- Schedule.update(schedule, schedule_params) do
        render(conn, "schedule.json", schedule: schedule)
      end
    else
      # work to other
      if schedule.title == :work do
        update_one_or_two_days_exp_hours(%{
          start: schedule.start,
          duration: schedule.duration,
          user_id: schedule.user_id,
          delete: true
        })

        with {:ok, schedule} <- Schedule.update(schedule, schedule_params) do
          render(conn, "schedule.json", schedule: schedule)
        end
      else
        # other to other
        with {:ok, schedule} <- Schedule.update(schedule, schedule_params) do
          render(conn, "schedule.json", schedule: schedule)
        end
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    schedule = Schedule.get(id)

    update_one_or_two_days_exp_hours(%{
      start: schedule.start,
      duration: schedule.duration,
      user_id: schedule.user_id,
      delete: true
    })

    with {:ok, %Schedule{}} <- Schedule.delete(schedule) do
      send_resp(conn, :no_content, "")
    end
  end
end
