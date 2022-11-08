defmodule ApiProject.HoursWorked do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias ApiProject.{Repo, HoursWorked, User}

  schema "hours_worked" do
    field(:date, :date)
    field(:normal_hours, :float, default: 0.0)
    field(:night_hours, :float, default: 0.0)
    field(:overtime_hours, :float, default: 0.0)
    field(:expected_worked_hours, :float, default: 0.0)
    belongs_to(:user, User)

    timestamps()
  end

  def changeset(hours_worked, attrs) do
    hours_worked
    |> cast(attrs, [
      :date,
      :normal_hours,
      :night_hours,
      :overtime_hours,
      :expected_worked_hours,
      :user_id
    ])
    |> validate_required([
      :date,
      :normal_hours,
      :night_hours,
      :overtime_hours,
      :expected_worked_hours,
      :user_id
    ])
  end

  def list_hours_worked do
    Repo.all(HoursWorked)
  end

  def get_hours_worked(id) do
    case Repo.get(HoursWorked, id) do
      nil -> {:hours_not_found, "Hours not found", 404}
      hours -> {:ok, hours}
    end
  end

  def get_hours_worked_by_user(user_id) do
    hours_worked =
      HoursWorked
      |> where([h], h.user_id == ^user_id)
      |> Repo.all()

    case hours_worked do
      nil -> {:not_found, "Hours not found for this user", 404}
      [] -> {:not_found, "This user don't have hours worked", 404}
      hours -> {:ok, hours}
    end
  end

  def get_hours_workeds_by_day(%{userId: user_id, date: date}) do
    hours_worked =
      HoursWorked
      |> where([h], h.user_id == ^user_id)
      |> where([h], h.date == ^date)
      |> Repo.one()

    case hours_worked do
      nil -> {:not_found, "Hours not found for this user", 404}
      [] -> {:not_found, "This user don't have hours worked", 404}
      hours -> {:ok, hours}
    end
  end

  def get_hours_worked_from_to(%{user_id: user_id, from: from, to: to}) do
    HoursWorked
    |> where([hw], hw.user_id == ^user_id)
    # this should be corrected, no need to store dateTime in DB, we want date .
    |> where([hw], fragment("?::date", hw.date) >= ^from)
    |> where([hw], fragment("?::date", hw.date) <= ^to)
    |> Repo.all()
  end

  def create_hours_worked(attrs \\ %{}) do
    %HoursWorked{}
    |> HoursWorked.changeset(attrs)
    |> Repo.insert()
  end

  def update_hours_worked(%HoursWorked{} = hours_worked, attrs) do
    hours_worked
    |> HoursWorked.changeset(attrs)
    |> Repo.update()
  end

  def delete_hours_worked(%HoursWorked{} = hours_worked) do
    Repo.delete(hours_worked)
  end

  def change_hours_worked(%HoursWorked{} = hours_worked, attrs \\ %{}) do
    HoursWorked.changeset(hours_worked, attrs)
  end
end
