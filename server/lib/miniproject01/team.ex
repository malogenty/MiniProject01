defmodule ApiProject.Team do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiProject.Team

  import Ecto.Query, warn: false
  alias ApiProject.Repo

  schema "teams" do
    field(:name, :string)
    field(:night_multiplicator, :float, default: 1.5)
    field(:overtime_multiplicator, :float, default: 2.0)
    field(:start_of_day, :time)
    field(:end_of_day, :time)

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
