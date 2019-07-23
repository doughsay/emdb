defmodule Emdb.Directors.Director do
  use Ecto.Schema
  import Ecto.Changeset

  alias Emdb.Movies.Movie

  schema "directors" do
    has_many :movies, Movie

    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(director, attrs) do
    director
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
