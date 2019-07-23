defmodule Emdb.Actors.Actor do
  use Ecto.Schema
  import Ecto.Changeset

  alias Emdb.Actors.Role
  alias Emdb.Movies.Movie

  schema "actors" do
    has_many :roles, Role
    many_to_many :movies, Movie, join_through: Role

    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(actor, attrs) do
    actor
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
