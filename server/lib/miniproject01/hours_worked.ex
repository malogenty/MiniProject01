defmodule ApiProject.HoursWorked do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias ApiProject.Repo
  alias ApiProject.HoursWorked

  schema "hours_worked" do
    field :date, :naive_datetime
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

  def get_hours_worked!(id), do: Repo.get!(HoursWorked, id)

  def get_hours_worked_by_user!(user_id) do
    HoursWorked
    |> where([h], h.user_id == ^user_id)
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
