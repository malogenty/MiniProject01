defmodule ApiProject.TeamsUsers do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
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

  def get_relation(%{user_id: user_id, team_id: team_id}) do
    TeamsUsers
    |> where([tu], tu.user_id == ^user_id)
    |> where([tu], tu.team_id == ^team_id)
    |> Repo.one()
  end

  def create_relation(params \\ %{}) do
    %TeamsUsers{}
    |> TeamsUsers.changeset(params)
    |> Repo.insert()
  end

  def delete_relation(relation) do
    Repo.delete(relation)
  end
end
