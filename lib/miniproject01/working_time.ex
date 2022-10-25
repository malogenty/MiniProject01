defmodule ApiProject.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias ApiProject.Repo
  alias ApiProject.WorkingTime


  schema "working_times" do
    field :end, :naive_datetime
    field :start, :naive_datetime

    belongs_to :user, ApiProject.User

    timestamps()
  end

  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:end, :start, :user_id])
    |> validate_required([:end, :start, :user_id])
  end

  def list_working_times do
    Repo.all(WorkingTime)
  end

  def get_working_time!(id), do: Repo.get!(WorkingTime, id)

  def get_working_time_by_user(%{user_id: user_id}) do
    Repo.all("working_times"
    |> where([w], w.user_id == ^user_id)
    |> select([:start]))
  end

  def create_working_time(attrs \\ %{}) do
    %WorkingTime{}
    |> WorkingTime.changeset(attrs)
    |> Repo.insert()
  end

  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end

  def change_working_time(%WorkingTime{} = working_time, attrs \\ %{}) do
    WorkingTime.changeset(working_time, attrs)
  end
end
