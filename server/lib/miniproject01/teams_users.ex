defmodule ApiProject.TeamsUsers do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiProject.{Repo, Team, User, TeamsUsers}

  schema "teams_users" do
    belongs_to(:team, Team)
    belongs_to(:user, User)
  end

  def changeset(teams_users, attrs) do
    teams_users
    |> cast(attrs, [:team_id, :user_id])
    |> validate_required([:team_id, :user_id])
  end

  def create_relation(params \\ %{}) do
    %TeamsUsers{}
    |> TeamsUsers.changeset(params)
    |> Repo.insert()
  end
end
