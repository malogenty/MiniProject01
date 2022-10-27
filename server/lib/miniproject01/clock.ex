defmodule ApiProject.Clock do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias ApiProject.Repo
  alias ApiProject.Clock

  schema "clocks" do
    field(:status, :boolean)
    field(:time, :naive_datetime)

    belongs_to(:user, ApiProject.User)

    timestamps()
  end

  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
  end

  def get_clocks_by_user(%{user_id: user_id}) do
    Clock
    |> Ecto.Query.preload([:user])
    |> where([c], c.user_id == ^user_id)
    |> Repo.all()
  end

  def create(attrs \\ %{}) do
    %Clock{}
    |> Repo.preload([:user])
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end
end
