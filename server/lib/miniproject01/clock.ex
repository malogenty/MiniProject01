defmodule ApiProject.Clock do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias ApiProject.Repo
  alias ApiProject.Clock
  alias ApiProject.User

  schema "clocks" do
    field(:status, :boolean)
    field(:time, :naive_datetime)
    belongs_to(:user, User)

    timestamps()
  end

  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
  end

  def get_clocks_by_user(%{user_id: user_id}) do
    Clock
    |> where([c], c.user_id == ^user_id)
    |> Repo.all()
  end

  def get_last_clock_by_user(%{user_id: user_id}) do
    clock =
      Repo.one(from(c in Clock, where: c.user_id == ^user_id, order_by: [desc: c.time], limit: 1))

    case clock do
      nil -> {:not_found, "Clocks not found for this user", 404}
      clock -> {:ok, clock}
    end
  end

  def create(attrs \\ %{}) do
    %Clock{}
    |> Repo.preload([:user])
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  def getEarlyDayOvertime(%{
        early_date: early_date,
        late_date: late_date,
        clock_in: clock_in,
        schedule_start: schedule_start
      }) do
    case {
      early_date < clock_in,
      clock_in < schedule_start,
      early_date < schedule_start,
      schedule_start < late_date,
      clock_in < late_date
    } do
      {true, true, true, true, _} -> NaiveDateTime.diff(schedule_start, clock_in, :minute)
      {false, true, true, true, _} -> NaiveDateTime.diff(schedule_start, early_date, :minute)
      {true, true, true, false, true} -> NaiveDateTime.diff(late_date, clock_in, :minute)
      _ -> 0
    end
  end

  def getLateDayOvertime(%{
        clock_out: clock_out,
        late_date: late_date,
        schedule_end: schedule_end,
        is_day_two: is_day_two
      }) do
    case {
      clock_out < late_date,
      schedule_end < clock_out,
      schedule_end < late_date,
      is_day_two
    } do
      {true, true, true, false} -> NaiveDateTime.diff(clock_out, schedule_end, :minute)
      {false, true, true, false} -> NaiveDateTime.diff(late_date, schedule_end, :minute)
      {_, _, _, true} -> 0
      _ -> 0
    end
  end

  def getLateNightOvertime(%{
        late_date: late_date,
        early_date: early_date,
        clock_out: clock_out,
        clock_in: clock_in,
        schedule_end: schedule_end,
        is_day_two: is_day_two
      }) do
    case {
      late_date < clock_out,
      schedule_end < clock_out,
      late_date < schedule_end,
      is_day_two,
      early_date < clock_out
    } do
      {true, true, true, false, _} -> NaiveDateTime.diff(clock_out, schedule_end, :minute)
      {true, true, false, false, _} -> NaiveDateTime.diff(clock_out, late_date, :minute)
      {false, true, false, true, true} -> NaiveDateTime.diff(early_date, schedule_end, :minute)
      {false, true, false, true, false} -> NaiveDateTime.diff(clock_out, schedule_end, :minute)
      _ -> 0
    end
  end

  def getEarlyNightOvertime(%{
        clock_in: clock_in,
        early_date: early_date,
        schedule_start: schedule_start,
        late_date: late_date
      }) do
    case {
      clock_in < early_date,
      clock_in < schedule_start,
      schedule_start < early_date,
      late_date < schedule_start,
      late_date < clock_in
    } do
      {true, true, true, false, _} -> NaiveDateTime.diff(schedule_start, clock_in, :minute)
      {true, true, false, false, _} -> NaiveDateTime.diff(early_date, clock_in, :minute)
      {false, true, false, true, true} -> NaiveDateTime.diff(schedule_start, clock_in, :minute)
      {false, true, false, true, false} -> NaiveDateTime.diff(schedule_start, late_date, :minute)
      _ -> 0
    end
  end

  def getEarlyNight(%{clock_in: clock_in, early_date: early_date, clock_out: clock_out}) do
    case {clock_in < early_date, clock_out < early_date} do
      {true, false} -> NaiveDateTime.diff(early_date, clock_in, :minute)
      {true, true} -> NaiveDateTime.diff(clock_out, clock_in, :minute)
      _ -> 0
    end
  end

  def getLateNight(%{late_date: late_date, clock_out: clock_out, clock_in: clock_in}) do
    case {late_date < clock_out, late_date < clock_in} do
      {true, false} -> NaiveDateTime.diff(clock_out, late_date, :minute)
      {true, true} -> NaiveDateTime.diff(clock_out, clock_in, :minute)
      _ -> 0
    end
  end

  def get_hours_by_day(%{
        clock_in: clock_in,
        clock_out: clock_out,
        schedule_end: schedule_end,
        schedule_start: schedule_start,
        day: day,
        is_day_two: is_day_two
      }) do
    {:ok, late_date} = NaiveDateTime.new(day, ~T[22:00:00])
    {:ok, early_date} = NaiveDateTime.new(day, ~T[05:00:00])

    # Day 1 night hours : 22h < hours
    late_day_1_night =
      getLateNight(%{late_date: late_date, clock_out: clock_out, clock_in: clock_in})

    # Day 1 night hours : hours < 5h
    early_day_1_night =
      getEarlyNight(%{clock_in: clock_in, early_date: early_date, clock_out: clock_out})

    # Calculate night overtime : overtime < 5h
    early_night_overtime =
      getEarlyNightOvertime(%{
        clock_in: clock_in,
        early_date: early_date,
        schedule_start: schedule_start,
        late_date: late_date
      })

    # Calculate night overtime : 22h < overtime
    late_night_overtime =
      getLateNightOvertime(%{
        late_date: late_date,
        early_date: early_date,
        clock_out: clock_out,
        clock_in: clock_in,
        schedule_end: schedule_end,
        is_day_two: is_day_two
      })

    # Calculate day overtime : overtime < 22h
    late_day_overtime =
      getLateDayOvertime(%{
        clock_out: clock_out,
        late_date: late_date,
        schedule_end: schedule_end,
        is_day_two: is_day_two
      })

    # Calculate day overtime : 5h < overtime
    early_day_overtime =
      getEarlyDayOvertime(%{
        early_date: early_date,
        late_date: late_date,
        clock_in: clock_in,
        schedule_start: schedule_start
      })

    night_hours =
      late_day_1_night + early_day_1_night - early_night_overtime - late_night_overtime

    overtime = early_day_overtime + late_day_overtime
    night_overtime = early_night_overtime + late_night_overtime

    %{
      early_night_overtime: early_night_overtime,
      late_night_overtime: late_night_overtime,
      early_day_overtime: early_day_overtime,
      late_day_overtime: late_day_overtime,
      night_hours: night_hours,
      day: day
    }
  end

  def get_hours(params) do
    schedule_start = params.schedule_start
    schedule_end = params.schedule_end
    clock_out = params.clock_out
    clock_in = params.clock_in

    {:ok, day_1} = Date.from_erl({schedule_start.year, schedule_start.month, schedule_start.day})

    {:ok, day_2} =
      Date.from_erl({schedule_start.year, schedule_start.month, schedule_start.day + 1})

    {:ok, day_2_midnight} = NaiveDateTime.new(day_2, ~T[00:00:00])

    total_hours = NaiveDateTime.diff(params.clock_out, params.clock_in, :minute)

    is_day_two = day_2_midnight < clock_out

    day_one_hours =
      case is_day_two do
        true ->
          get_hours_by_day(%{
            clock_in: clock_in,
            clock_out: day_2_midnight,
            schedule_end: schedule_end,
            schedule_start: schedule_start,
            day: day_1,
            is_day_two: is_day_two
          })

        false ->
          get_hours_by_day(%{
            clock_in: clock_in,
            clock_out: clock_out,
            schedule_end: schedule_end,
            schedule_start: schedule_start,
            day: day_1,
            is_day_two: is_day_two
          })
      end

    day_two_hours =
      case day_2_midnight < clock_out do
        true ->
          get_hours_by_day(%{
            clock_in: day_2_midnight,
            clock_out: clock_out,
            schedule_end: schedule_end,
            schedule_start: day_2_midnight,
            day: day_2,
            is_day_two: is_day_two
          })

        false ->
          %{
            early_night_overtime: 0,
            late_night_overtime: 0,
            early_day_overtime: 0,
            late_day_overtime: 0,
            night_hours: 0
          }
      end

    night_hours = day_one_hours.night_hours + day_two_hours.night_hours

    overtime =
      day_one_hours.late_day_overtime + day_two_hours.late_day_overtime +
        day_one_hours.early_day_overtime + day_two_hours.early_day_overtime

    night_overtime =
      day_one_hours.early_night_overtime + day_two_hours.early_night_overtime +
        day_one_hours.late_night_overtime + day_two_hours.late_night_overtime

    %{
      night_overtime: night_overtime,
      overtime: overtime,
      night_hours: day_one_hours.night_hours + day_two_hours.night_hours,
      normal_hours: total_hours - night_hours - overtime - night_overtime
    }
  end
end
