defmodule ApiProject.HoursWorked do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias ApiProject.Repo
  alias ApiProject.HoursWorked
  alias ApiProject.TeamsUsers

  schema "hours_worked" do
    field :date, :date
    field :normal_hours, :float
    field :night_hours, :float
    field :overtime_hours, :float
    field :expected_worked_hours, :float
    belongs_to(:user, User)

    timestamps()
  end

  def changeset(hours_worked, attrs) do
    hours_worked
    |> cast(attrs, [:date, :normal_hours, :night_hours, :overtime_hours, :expected_worked_hours, :user_id])
    |> validate_required([:date, :normal_hours, :night_hours, :overtime_hours, :expected_worked_hours, :user_id])
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
    hours_worked = HoursWorked
    |> where([h], h.user_id == ^user_id)
    |> Repo.all()
    case hours_worked do
      nil -> {:not_found, "Hours not found for this user", 404}
      [] -> {:not_found, "This user don't have hours worked", 404}
      hours -> {:ok, hours}
    end
  end

  def get_avg_hours_by_team(%{"team_id": team_id, "from": from, "to": to}) do
    query = from(
      h in HoursWorked,
      join: t in TeamsUsers,
      on: h.user_id == t.user_id,
      where: t.team_id == ^team_id,
      where: fragment("? BETWEEN ? AND ?", h.date, ^from, ^to),
      group_by: h.date,
      select: %{date: h.date, avg_normal: avg(h.normal_hours), avg_night: avg(h.night_hours), avg_overtime: avg(h.overtime_hours)}
    )
    Repo.all(query)
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
