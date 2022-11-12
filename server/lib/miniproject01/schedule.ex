defmodule ApiProject.Schedule do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias ApiProject.{Repo, Schedule, User}

  schema "schedule" do
    field(:start, :naive_datetime)
    field(:duration, :float, default: 4.0)
    field(:end, :naive_datetime)
    field(:title, Ecto.Enum, values: [:work, :holiday, :sick])
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:user_id, :start, :duration, :title, :end])
    |> validate_required([:user_id, :start, :duration, :title, :end])
  end

  def get(id) do
    Schedule
    |> Repo.get(id)
  end

  def get_by_time(%{user_id: user_id, start: start_date, end: end_date}) do
    Schedule
    |> Ecto.Query.preload([:user])
    |> where([w], w.user_id == ^user_id)
    |> where([w], fragment("?::date", w.start) >= ^start_date)
    |> where([w], fragment("?::date", w.start) <= ^end_date)
    |> order_by([w], w.start)
    |> Repo.all()
  end

  def get_work_by_date(%{user_id: user_id, date: date}) do
    Schedule
    |> Ecto.Query.preload([:user])
    |> where([w], w.user_id == ^user_id)
    |> where([w], w.title == :work)
    |> where([w], fragment("?::date", w.start) == ^date)
    |> or_where([w], fragment("?::date", w.end) == ^date)
    |> order_by([w], asc: w.start)
    |> Repo.all()
  end

  def get_by_user(%{user_id: user_id}) do
    Schedule
    |> Ecto.Query.preload([:user])
    |> where([w], w.user_id == ^user_id)
    |> Repo.all()
  end

  def create(schedule_params \\ %{}) do
    %Schedule{}
    |> Schedule.changeset(schedule_params)
    |> Repo.insert()
  end

  def update(%Schedule{} = schedule, schedule_params) do
    schedule
    |> Schedule.changeset(schedule_params)
    |> Repo.update()
  end

  def delete(schedule) do
    Repo.delete(schedule)
  end
end
