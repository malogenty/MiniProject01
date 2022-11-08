defmodule ApiProject.Schedule do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias ApiProject.Repo
  alias ApiProject.Schedule
  alias ApiProject.User

  schema "schedule" do
    field(:start, :naive_datetime)
    field(:duration, :float, default: 4.0)
    field(:title, :string)
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:user_id, :start, :duration, :title])
    |> validate_required([:user_id, :start, :duration, :title])
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
