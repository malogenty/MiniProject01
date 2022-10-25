defmodule ApiProject.User do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset
  import EctoCommons.EmailValidator

  import Ecto.Query, warn: false
  alias ApiProject.Repo
  alias ApiProject.User

  schema "users" do
    field(:email, :string)
    field(:username, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_email(:email, checks: [:html_input])
    |> validate_required([:username, :email])
  end

  def get_user_with_credentials(%{email: email, username: username}) do
    Repo.get_by(User, email: email, username: username)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, user} -> {:ok, user}
      {:error, _} -> :error
    end
  end
end
