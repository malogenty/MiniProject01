defmodule ApiProject.Repo.Migrations.AlterUsers do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE user_role AS ENUM ('general_manager', 'manager', 'employee')"
    execute(create_query)

    alter table(:users) do
      add(:hour_rate, :float, default: 7.25)
      add(:role, :user_role)
    end
  end
end
