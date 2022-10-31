defmodule ApiProject.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add(:name, :string, null: false)
      add(:night_multiplicator, :float, default: 1.5)
      add(:overtime_multiplicator, :float, default: 2)
      add(:start_of_day, :time)
      add(:end_of_day, :time)

      timestamps()
    end
  end
end
