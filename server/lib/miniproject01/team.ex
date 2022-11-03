defmodule ApiProject.Team do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiProject.{Repo, Team, User, TeamsUsers}

  import Ecto.Query, warn: false

  schema "teams" do
    field(:name, :string)
    field(:night_multiplicator, :float, default: 1.5)
    field(:overtime_multiplicator, :float, default: 2.0)
    field(:start_of_day, :time)
    field(:end_of_day, :time)
    many_to_many(:users, User, join_through: "teams_users")

    timestamps()
  end

  def changeset(team, attrs) do
    team
    |> cast(attrs, [
      :name,
      :night_multiplicator,
      :overtime_multiplicator,
      :start_of_day,
      :end_of_day
    ])
    |> validate_required([
      :name,
      :night_multiplicator,
      :overtime_multiplicator,
      :start_of_day,
      :end_of_day
    ])
  end

  def get_team!(id) do
    Repo.get(Team, id)
  end

  def get_team_users(team_id) do
    query =
      from(
        u in User,
        join: tu in TeamsUsers,
        on: u.id == tu.user_id,
        join: t in Team,
        on: tu.team_id == t.id,
        where: tu.team_id == ^team_id,
        select: u
      )

    Repo.all(query)
  end

  def are_same_team(%{u1_id: u1_id, u2_id: u2_id}) do
    child_query = from(tu in TeamsUsers, where: tu.user_id == ^u2_id, select: tu.team_id)

    query =
      from(
        tu in TeamsUsers,
        where: tu.user_id == ^u1_id,
        where: tu.team_id in subquery(child_query),
        select: tu
      )

    res = Repo.all(query)
    length(res) > 0
  end

  def create_team(team_params \\ %{}) do
    %Team{}
    |> Team.changeset(team_params)
    |> Repo.insert()
  end

  def update_team(%Team{} = team, team_params) do
    team
    |> Team.changeset(team_params)
    |> Repo.update()
  end

  def delete_team(team) do
    Repo.delete(team)
  end
end
