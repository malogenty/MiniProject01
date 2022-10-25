defmodule ApiProject.Clock do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  import IO
  alias ApiProject.Repo
  alias ApiProject.Clock
  alias ApiProject.User

  schema "clocks" do
    field(:status, :boolean, default: true)
    field(:time, :naive_datetime)
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:user, :time, :status])
    |> validate_required([:user, :time, :status])
  end

  def create(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, clock} -> {:ok, clock}
      {:error, _} -> :error
    end
  end

  def select(userId) do
    from(clock in Clock, where: clock.user == ^userId) |> Repo.all()
  end
end
