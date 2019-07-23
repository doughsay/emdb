defmodule EmdbWeb.Schema.MovieTypes do
  use Absinthe.Schema.Notation

  alias EmdbWeb.Resolvers.{MoviesResolver, DirectorsResolver}

  import_types EmdbWeb.Schema.DirectorTypes

  @desc "A cool 80's movie"
  object :movie do
    field :title, non_null(:string)
    field :year, non_null(:integer)
    field :director, non_null(:director), resolve: &DirectorsResolver.director/3
  end

  object :movie_queries do
    @desc "List all 80's movies"
    field :movies, non_null(list_of(non_null(:movie))), resolve: &MoviesResolver.movies/3
  end
end
