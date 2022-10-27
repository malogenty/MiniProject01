defmodule ApiProject.Clock do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias ApiProject.Repo
  alias ApiProject.Clock

  schema "clocks" do
    field(:status, :boolean, default: true)
    field(:time, :naive_datetime)

    belongs_to :user, ApiProject.User

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:user_id, :time, :status])
    |> validate_required([:user_id, :time, :status])
  end

  def create(attrs \\ %{}) do
    %Clock{}
    |> Repo.preload([:user])
    |> Clock.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, clock} -> {:ok, clock}
      {:error, _} -> :error
    end
  end

  def select(userId) do
    from(clock in Clock, where: clock.user_id == ^userId) |> Repo.all()
  end
end
