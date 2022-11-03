defmodule ApiProject.Schedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schedule" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    field :title, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:user_id, :start, :end, :title])
    |> validate_required([:user_id, :start, :end, :title])
  end
end
