defmodule Emdb.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies" do
    field :title, :string
    field :year, :integer
    field :director_id, :id

    timestamps()
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :year])
    |> validate_required([:title, :year])
  end
end
