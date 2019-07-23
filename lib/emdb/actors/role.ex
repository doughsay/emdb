defmodule Emdb.Actors.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :actor_id, :id
    field :movie_id, :id

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [])
    |> validate_required([])
  end
end
