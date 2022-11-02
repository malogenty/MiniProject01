defmodule ApiProject.Repo.Migrations.CreateSchedule do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE title AS ENUM ('work', 'holiday', 'sick')"
    execute(create_query)

    create table(:schedule) do
      add(:user_id, references(:users, on_delete: :delete_all))
      add :start, :naive_datetime
      add :end, :naive_datetime
      add :title, :string, default: "work"

      timestamps()
    end
  end
end
