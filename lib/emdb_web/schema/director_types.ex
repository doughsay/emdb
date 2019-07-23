defmodule EmdbWeb.Schema.DirectorTypes do
  use Absinthe.Schema.Notation

  alias EmdbWeb.Resolvers.MoviesResolver

  @desc "An 80's movie director"
  object :director do
    field :name, non_null(:string)

    field :movies, non_null(list_of(non_null(:movie))),
      resolve: &MoviesResolver.movies_for_director/3
  end
end
