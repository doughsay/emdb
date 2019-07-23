defmodule Emdb.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  alias Emdb.Actors.{Actor, Role}
  alias Emdb.Directors.Director

  schema "movies" do
    belongs_to :director, Director
    has_many :roles, Role
    many_to_many :actors, Actor, join_through: Role

    field :title, :string
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :year, :director_id])
    |> validate_required([:title, :year, :director_id])
  end
end
