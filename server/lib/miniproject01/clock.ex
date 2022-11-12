defmodule ApiProject.Clock do
  require Logger
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias ApiProject.{Repo, Clock, User}

  schema "clocks" do
    field(:status, :boolean)
    field(:time, :naive_datetime)
    belongs_to(:user, User)

    timestamps()
  end

  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
  end

  def get_clocks_by_user(%{user_id: user_id}) do
    Clock
    |> where([c], c.user_id == ^user_id)
    |> Repo.all()
  end

  def get_last_clock_by_user(%{user_id: user_id}) do
    Repo.one(from(c in Clock, where: c.user_id == ^user_id, order_by: [desc: c.time], limit: 1))
  end

  def create(attrs \\ %{}) do
    %Clock{}
    |> Repo.preload([:user])
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end
end
