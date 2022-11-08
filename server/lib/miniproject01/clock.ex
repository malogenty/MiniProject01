defmodule ApiProject.Clock do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias ApiProject.Repo
  alias ApiProject.Clock
  alias ApiProject.User

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
    clock = Repo.one(from c in Clock, where: c.user_id == ^user_id, order_by: [desc: c.time], limit: 1)
    case clock do
      nil -> {:not_found, "Clocks not found for this user", 404}
      clock -> {:ok, clock}
    end
  end

  def create(attrs \\ %{}) do
    %Clock{}
    |> Repo.preload([:user])
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end
end
