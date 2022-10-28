defmodule ApiProject.User do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset
  import EctoCommons.EmailValidator

  import Ecto.Query, warn: false
  alias ApiProject.Repo
  alias ApiProject.User
  alias ApiProject.WorkingTime

  schema "users" do
    field(:email, :string)
    field(:username, :string)
    has_many(:workingtimes, WorkingTime)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_email(:email, checks: [:html_input])
    |> validate_required([:username, :email])
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

  def update_user(%User{} = user, user_params) do
    user
    |> User.changeset(user_params)
    |> Repo.update()
  end

  def delete_user(user) do
    Repo.delete(user)
  end
end
