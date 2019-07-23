defmodule EmdbWeb.Schema.ActorTypes do
  use Absinthe.Schema.Notation

  alias EmdbWeb.Resolvers.MoviesResolver

  @desc "An actor in an 80's movie"
  object :actor do
    field :name, non_null(:string)

    field :movies, non_null(list_of(non_null(:movie))),
      resolve: &MoviesResolver.movies_for_actor/3
  end
end
