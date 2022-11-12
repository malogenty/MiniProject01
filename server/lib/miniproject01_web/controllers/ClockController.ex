defmodule ApiProjectWeb.ClockController do
  require Logger
  use ApiProjectWeb, :controller
  alias ApiProject.{Clock, HoursWorked, Schedule, User, Team}

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

  # helper method
  def get_night_hours(user_id, clock_in_time, clock_out_time) do
    %{:start_of_day => start_of_day, :end_of_day => end_of_day} =
      Team.get_team!(List.first(User.get_user_teams(user_id)).id)

    # everything that is over 0 is night work

    start_in =
      if Time.diff(start_of_day, clock_in_time, :second) / 60 / 60 > 0 do
        Time.diff(start_of_day, clock_in_time, :second) / 60 / 60
      else
        0
      end

    start_out =
      if Time.diff(start_of_day, clock_out_time, :second) / 60 / 60 > 0 do
        Time.diff(start_of_day, clock_out_time, :second) / 60 / 60
      else
        0
      end

    end_in =
      if Time.diff(clock_in_time, end_of_day, :second) / 60 / 60 > 0 do
        Time.diff(clock_in_time, end_of_day, :second) / 60 / 60
      else
        0
      end

    end_out =
      if Time.diff(clock_out_time, end_of_day, :second) / 60 / 60 > 0 do
        Time.diff(clock_out_time, end_of_day, :second) / 60 / 60
      else
        0
      end

    # let's say start_of_day = 8am
    # clock_in = 4am
    # clock_out = 7am
    # start_out = diff(7am, 8am) = 1hr
    # start_in = diff(4am, 8am) = 4hr
    # total hrs worked should be 3hrs, not 5
    # so we return start_in - start_out

    # if clock_out = 9am
    # start_out = diff(9am, 8am) = -1hr --> 0
    # hrs_worked = 4hr + 0 --> 4hr

    morning_hours =
      if start_in > 0 && start_out > 0 do
        start_in - start_out
      else
        start_out + start_in
      end

    late_hours =
      if end_in > 0 && end_out > 0 do
        end_out - end_in
      else
        end_in + end_out
      end

    morning_hours + late_hours
  end

  def get_list_of_overtime_events(ev_list) do
    ev_list =
      ev_list
      |> Enum.with_index()
      |> Enum.flat_map(fn {event, i} ->
        event = Map.put(event, :end, event.start)

        if i == 0 do
          {:ok, new_date} = NaiveDateTime.new(NaiveDateTime.to_date(event.start), ~T[00:00:00])
          [Map.put(event, :start, new_date)]
        else
          ev_before = Enum.at(ev_list, i - 1)
          [Map.put(event, :start, ev_before.end)]
        end
      end)

    for ev <- ev_list do
      %{
        start: ev.start,
        end: ev.end
      }
    end
  end

  def check_with_times_of_day(time_one, time_two, start_of_day, end_of_day) do
    cond do
      Time.compare(time_one, start_of_day) == :lt && Time.compare(time_two, start_of_day) == :lt ->
        abs(Time.diff(time_one, time_two)) / 60 / 60

      Time.compare(time_one, start_of_day) == :lt && Time.compare(time_two, start_of_day) == :gt ->
        abs(Time.diff(time_one, start_of_day)) / 60 / 60

      Time.compare(time_one, end_of_day) == :lt && Time.compare(time_two, end_of_day) == :gt ->
        abs(Time.diff(time_two, end_of_day)) / 60 / 60

      Time.compare(time_one, end_of_day) == :gt && Time.compare(time_two, end_of_day) == :gt ->
        abs(Time.diff(time_one, time_two)) / 60 / 60

      true ->
        0
    end
  end

  def check_case(clock_in, clock_out, event, user_id) do
    %{:start_of_day => start_of_day, :end_of_day => end_of_day} =
      Team.get_team!(List.first(User.get_user_teams(user_id)).id)

    cond do
      Time.compare(clock_in, event.start) == :gt && Time.compare(clock_in, event.end) == :gt ->
        0

      Time.compare(clock_in, event.start) == :gt && Time.compare(clock_out, event.end) == :lt ->
        check_with_times_of_day(clock_in, clock_out, start_of_day, end_of_day)

      Time.compare(clock_in, event.start) == :lt && Time.compare(clock_out, event.end) == :lt &&
          Time.compare(clock_out, event.start) == :gt ->
        check_with_times_of_day(event.start, clock_out, start_of_day, end_of_day)

      Time.compare(clock_in, event.start) == :gt && Time.compare(clock_out, event.end) == :gt ->
        check_with_times_of_day(clock_in, event.end, start_of_day, end_of_day)

      Time.compare(clock_in, event.start) == :lt && Time.compare(clock_out, event.end) == :gt ->
        check_with_times_of_day(event.start, event.end, start_of_day, end_of_day)
    end
  end

  def get_night_overtime(user_id, clock_in, clock_out, ev_list) do
    %{:start_of_day => start_of_day, :end_of_day => end_of_day} =
      Team.get_team!(List.first(User.get_user_teams(user_id)).id)

    overtime_list = get_list_of_overtime_events(ev_list)

    end_of_day = ~T[20:00:00]
    {:ok, clock_out} = NaiveDateTime.new(NaiveDateTime.to_date(clock_out), ~T[22:30:00])

    # do logic here, and there
    overtime_list
    |> Enum.each(fn event ->
      Logger.info(%{val: check_case(clock_in, clock_out, event, user_id)})
    end)

    %{
      start_of_day: start_of_day,
      end_of_day: end_of_day,
      before:
        for event <- ev_list do
          %{
            start: event.start,
            end: event.end
          }
        end,
      now: overtime_list
    }
  end

  def format_schedule_event_to_be_single_day(ev, day) do
    start_day = NaiveDateTime.to_date(ev.start)
    end_day = NaiveDateTime.to_date(ev.end)

    if start_day == end_day do
      ev
    else
      cond do
        Date.compare(day, end_day) == :lt ->
          {:ok, late} = NaiveDateTime.new(day, ~T[23:59:59])
          Map.put(ev, :end, late)

        Date.compare(day, start_day) == :gt ->
          {:ok, early} = NaiveDateTime.new(day, ~T[00:00:00])
          Map.put(ev, :start, early)
      end
    end
  end

  def create_hours_worked(%{clock_in: clock_in, clock_out: clock_out, user_id: user_id}) do
    date = NaiveDateTime.to_date(clock_in)
    period_worked_hours = Time.diff(clock_out, clock_in, :second) / 60 / 60

    %{:done => hrs_done, :expected => hrs_expected} =
      HoursWorked.get_done_and_expected(%{user_id: user_id, date: date})

    if hrs_expected == 0 do
      night_hours = get_night_hours(user_id, clock_in, clock_out)
      normal_hours = period_worked_hours - night_hours

      with {:ok, hours} <- HoursWorked.get_hours_worked_by_day(%{userId: user_id, date: date}) do
        with {:ok, updated} <-
               HoursWorked.update_hours_worked(hours, %{
                 night_hours: night_hours,
                 normal_hours: normal_hours
               }) do
          %{
            date: updated.date,
            expected: updated.expected_worked_hours,
            night: updated.night_hours,
            overtime: updated.overtime_hours,
            overtime_night: updated.overtime_night_hours
          }
        else
          {:error, %Ecto.Changeset{}} -> %{error: "unable to update"}
        end
      else
        {:not_found, reason, status} ->
          with {:ok, %HoursWorked{} = hours} <-
                 HoursWorked.create_hours_worked(%{
                   user_id: user_id,
                   date: date,
                   normal_hours: normal_hours,
                   night_hours: night_hours
                 }) do
            %{created: %{id: hours.id, expected: hours.expected_worked_hours}}
          end
      end
    else
      # there is a schedule.
      schedule = Schedule.get_work_by_date(%{user_id: user_id, date: date})

      ev_list =
        for sched_ev <- schedule do
          format_schedule_event_to_be_single_day(sched_ev, date)
        end

      overnight = get_night_overtime(user_id, clock_in, clock_out, ev_list)

      %{
        hours_expected: hrs_expected,
        hours_done: hrs_done,
        clock_in: clock_in,
        clock_out: clock_out,
        hrs_clocked: period_worked_hours,
        events:
          for ev <- schedule do
            %{start: ev.start, end: ev.end}
          end,
        overnight: overnight
      }
    end
  end

  def create_test(conn, %{"userId" => user_id}) do
    today_datetime = NaiveDateTime.utc_now()
    clock = Clock.get_last_clock_by_user(%{user_id: user_id})

    status =
      if !is_nil(clock) do
        !clock.status
      else
        true
      end

    if(status && !is_nil(clock)) do
      day_1 = NaiveDateTime.to_date(clock.time)
      day_2 = NaiveDateTime.to_date(today_datetime)

      if(day_1 == day_2) do
        hrs_clocked = NaiveDateTime.diff(today_datetime, clock.time, :second) / 60 / 60
        day = create_hours_worked(day_1)
        json(conn, %{day: day})
      else
        {:ok, almost_midnight} = NaiveDateTime.new(day_1, ~T[23:59:59])
        {:ok, early_midnight} = NaiveDateTime.new(day_2, ~T[00:00:00])
        {:ok, six_am} = NaiveDateTime.new(day_1, ~T[06:00:00])
        {:ok, two_am} = NaiveDateTime.new(day_2, ~T[02:00:00])
        # split into two days, and create hours_worked for each day.

        day_1_hrs =
          create_hours_worked(%{
            user_id: user_id,
            clock_in: clock.time,
            clock_out: almost_midnight
          })

        day_2_hrs =
          create_hours_worked(%{
            user_id: user_id,
            clock_in: two_am,
            clock_out: today_datetime
          })

        json(conn, %{day_1: day_1_hrs, day_2: day_2_hrs})
      end
    else
      send_resp(conn, 204, "")
    end
  end

  def create_disabled(conn, %{"userId" => user_id, "status" => status}) do
    # get right schedule
    today_datetime = NaiveDateTime.utc_now()

    day_schedules =
      Schedule.get_expected_hours(%{
        user_id: user_id,
        start: ~N[2022-11-10 08:00:00],
        end: ~N[2022-11-10 13:00:00]
      })

    json(
      conn,
      %{
        schedules:
          for schedule <- day_schedules do
            %{
              date: schedule.start,
              duration: schedule.duration
            }
          end
      }
    )

    schedule =
      with {:ok, last} <- Clock.get_last_clock_by_user(%{user_id: user_id}),
           {:check_status, true, _x} <- {:check_status, status != last.status, last.status},
           {:ok, %Clock{} = clock} <-
             Clock.create(%{user_id: user_id, time: today_datetime, status: status}),
           {:is_clock_out, true, clock} <- {:is_clock_out, !status, clock},
           schedule <-
             Schedule.get_by_time(%{
               user_id: user_id,
               start: NaiveDateTime.to_date(last.time),
               end: NaiveDateTime.to_date(today_datetime)
             }),
           {result, schedule} <-
             {Clock.get_hours(%{
                clock_in: last.time,
                clock_out: clock.time,
                schedule_end:
                  if schedule do
                    NaiveDateTime.add(schedule.start, schedule.duration, :hour)
                  else
                    nil
                  end,
                schedule_start:
                  if schedule do
                    schedule.start
                  else
                    nil
                  end
              }), schedule},
           #  do conn |> render("message.json", message: result)
           {:ok, %HoursWorked{} = hours_worked} <-
             HoursWorked.create_hours_worked(%{
               date: today_datetime,
               normal_hours: result.normal_hours,
               night_hours: result.night_hours,
               overtime_hours: result.overtime,
               # night_overtime: night_overtime,
               expected_worked_hours:
                 if schedule do
                   NaiveDateTime.diff(
                     NaiveDateTime.add(schedule.start, schedule.duration, :hour),
                     schedule.start,
                     :second
                   ) / 60 / 60
                 else
                   0
                 end,
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

        {:is_clock_out, false, clock} ->
          conn
          |> put_status(200)
          |> render("clock.json", clock: clock)
      end
  end
end
