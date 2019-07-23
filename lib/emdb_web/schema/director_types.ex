defmodule EmdbWeb.Schema.DirectorTypes do
  use Absinthe.Schema.Notation

  alias EmdbWeb.Resolvers.{MoviesResolver, DirectorsResolver}

  @desc "An 80's movie director"
  object :director do
    field :name, non_null(:string)

    field :movies, non_null(list_of(non_null(:movie))),
      resolve: &MoviesResolver.movies_for_director/3
  end

  object :director_queries do
    @desc "Search 80's directors by name"
    field :directors, non_null(list_of(non_null(:director))) do
      arg :search_term, non_null(:string)
      resolve &DirectorsResolver.directors/3
    end
  end
end
