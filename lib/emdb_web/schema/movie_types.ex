defmodule EmdbWeb.Schema.MovieTypes do
  use Absinthe.Schema.Notation

  alias EmdbWeb.Resolvers.{MoviesResolver, DirectorsResolver, ActorsResolver}

  @desc "A cool 80's movie"
  object :movie do
    field :title, non_null(:string)
    field :year, non_null(:integer)
    field :director, non_null(:director), resolve: &DirectorsResolver.director/3

    field :actors, non_null(list_of(non_null(:actor))),
      resolve: &ActorsResolver.actors_for_movie/3
  end

  object :movie_queries do
    @desc "Search 80's movies by title"
    field :movies, non_null(list_of(non_null(:movie))) do
      arg :search_term, non_null(:string)
      resolve &MoviesResolver.movies/3
    end
  end
end
