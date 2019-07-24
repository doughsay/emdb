defmodule EmdbWeb.Schema.ActorTypes do
  use Absinthe.Schema.Notation

  alias EmdbWeb.Resolvers.{MoviesResolver, ActorsResolver}

  @desc "An actor in an 80's movie"
  object :actor do
    field :name, non_null(:string)

    field :movies, non_null(list_of(non_null(:movie))),
      resolve: &MoviesResolver.movies_for_actor/3
  end

  object :actor_queries do
    @desc "Search 80's actors by name"
    field :actors, non_null(list_of(non_null(:actor))) do
      arg :search_term, non_null(:string)
      resolve &ActorsResolver.actors/3
    end
  end
end
