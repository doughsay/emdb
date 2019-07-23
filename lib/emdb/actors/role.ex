defmodule Emdb.Actors.Role do
  use Ecto.Schema
  import Ecto.Changeset

  alias Emdb.Actors.Actor
  alias Emdb.Movies.Movie

  schema "roles" do
    belongs_to :actor, Actor
    belongs_to :movie, Movie

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:actor_id, :movie_id])
    |> validate_required([:actor_id, :movie_id])
  end
end
