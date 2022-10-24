defmodule ApiProject.User do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoCommons.EmailValidator
  import Ecto.Query, warn: false
  alias ApiProject.Repo

  schema "users" do
    field(:email, :string)
    field(:username, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_email(:email)
    |> validate_required([:username, :email])
  end

  def get_user!(id) do Repo.get!(Users, id)

  def get_user_by_credentials!(email, username) do
    query = from u in "users", where: u.email = email AND u.username = username, select: *
    Repo.all(query)
  end

  def create_user(attrs \\ %{}) do
      %Users{}
      |> Users.changeset(attrs)
      |> Repo.insert()
  end

  def update_users(%Users{} = users, attrs) do
    users
    |> Users.changeset(attrs)
    |> Repo.update()
  end

  def delete_users(%Users{} = users) do
    Repo.delete(users)
  end
end
