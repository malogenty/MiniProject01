defmodule ApiProject.User do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset
  import EctoCommons.EmailValidator

  import Ecto.Query, warn: false
  alias ApiProject.{Repo, User, WorkingTime, Clock, Team, TeamsUsers}

  schema "users" do
    field(:email, :string)
    field(:username, :string)
    field(:role, Ecto.Enum, values: [:general_manager, :manager, :employee])
    field(:hour_rate, :float, default: 7.5)
    has_many(:workingtimes, WorkingTime)
    has_many(:clocks, Clock)
    many_to_many(:teams, Team, join_through: "teams_users")

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role, :hour_rate])
    |> validate_email(:email, checks: [:html_input])
    |> validate_required([:username, :email, :role, :hour_rate])
    |> unique_constraint(:username, message: "This username is already taken")
  end

  def get_user_with_credentials(%{email: email, username: username}) do
    Repo.get_by(User, email: email, username: username)
  end

  def get_all() do
    Repo.all(User)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def create_user(user_params \\ %{}) do
    %User{}
    |> User.changeset(user_params)
    |> Repo.insert()
  end

  def get_user_teams(user_id) do
    query =
      from(
        t in Team,
        join: tu in TeamsUsers,
        on: t.id == tu.team_id,
        join: u in User,
        on: u.id == tu.user_id,
        where: tu.user_id == ^user_id,
        select: t
      )

    Repo.all(query)
  end

  def update_user(%User{} = user, user_params) do
    user
    |> User.changeset(user_params)
    |> Repo.update()
  end

  def delete_user(user) do
    Repo.delete(user)
  end
end
