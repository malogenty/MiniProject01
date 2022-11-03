defmodule ApiProject.Schedule do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias ApiProject.Repo
  alias ApiProject.Schedule

  schema "schedule" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    field :title, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:user_id, :start, :end, :title])
    |> validate_required([:user_id, :start, :end, :title])
  end

  def get(id) do
    Repo.get(Schedule, id)
  end

  def get_by_time(%{user_id: user_id, start: start_datetime, end: end_datetime}) do
    Schedule
    |> Ecto.Query.preload([:user])
    |> where([w], w.user_id == ^user_id)
    |> where([w], w.start >= ^start_datetime)
    |> where([w], w.end <= ^end_datetime)
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

  #def update(%Schedule = schedule, schedule_params) do
  #  schedule
  #  |> Schedule.changeset(schedule_params)
  #  |> Repo.update()
  #end

  def delete(schedule) do
    Repo.delete(schedule)
  end
end
