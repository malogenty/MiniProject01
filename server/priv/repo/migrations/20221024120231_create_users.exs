defmodule ApiProject.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE user_role AS ENUM ('general_manager', 'manager', 'employee')"
    execute(create_query)

    create table(:users) do
      add(:username, :string, null: false)
      add(:email, :string, null: false)
      add(:hour_rate, :float, default: 7.25)
      add(:role, :user_role)

      timestamps()
    end

    create(unique_index(:users, [:username, :email], name: :username_and_email_unique))
  end
end
