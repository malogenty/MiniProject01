defmodule ApiProject.Repo.Migrations.CreateHoursWorked do
  use Ecto.Migration

  def change do
    create table(:hours_worked) do
      add(:date, :date)
      add(:normal_hours, :float)
      add(:night_hours, :float)
      add(:overtime_hours, :float)
      add(:expected_worked_hours, :float)
      add(:overtime_night_hours, :float)
      add(:user_id, references(:users, on_delete: :delete_all))

      timestamps()
    end
  end
end
