defmodule ApiProject.User do
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
    |> validate_email(:email)
    |> validate_required([:username, :email])
  end

  def get_user(id) do
    Repo.get(User, id)
  end
end
