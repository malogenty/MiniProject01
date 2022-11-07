defmodule ApiProjectWeb.ScheduleController do
  require Logger
  use ApiProjectWeb, :controller
  alias ApiProject.Schedule

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
    # with {:ok, %Schedule{} = schedule} <-
    #        Schedule.create(%{
    #          "user_id" => user_id,
    #          "title" => title,
    #          "start" => start_datetime,
    #          "end" => end_datetime
    #        }) do
    #   conn
    #   |> render("schedule.json", schedule: schedule)
    # end
    {:ok, st_date} = NaiveDateTime.from_iso8601(schedule_params["start"])
    {:ok, e_date} = NaiveDateTime.from_iso8601(schedule_params["end"])

    if st_date.day == e_date.day && st_date.month == e_date.month && st_date.year == e_date.year do
      cond do
        schedule_params["title"] == "work" ->
          hrs_to_work = NaiveDateTime.diff(e_date, st_date, :second) / 60 / 60
          obj = %{hrs_: hrs_to_work}
          json(conn, obj)
      end

      # not same day ! needs to check time before && after midnight
    else
      {:ok, st_midnight} =
        NaiveDateTime.new(st_date.year, st_date.month, st_date.day, 23, 59, 59, 999)

      day_1_hours = round(abs(NaiveDateTime.diff(st_date, st_midnight, :second) / 60 / 60))
      day_2_hours = round(abs(NaiveDateTime.diff(e_date, st_midnight, :second) / 60 / 60))

      cond do
        day_2_hours < 24 ->
          json(conn, %{day1: day_1_hours, day2: day_2_hours})

        true ->
          send_resp(conn, 401, "Too Long")
      end

      json(conn, %{start: st_date, midnight: st_midnight})
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
