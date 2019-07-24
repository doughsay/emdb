defmodule EmdbWeb.Schema do
  use Absinthe.Schema
  use ApolloTracing

  import_types EmdbWeb.Schema.DirectorTypes
  import_types EmdbWeb.Schema.ActorTypes
  import_types EmdbWeb.Schema.MovieTypes

  query do
    @desc "Check that the server is running"
    field :health, non_null(:string) do
      resolve fn _, _ -> {:ok, "alive!"} end
    end

    import_fields :movie_queries
    import_fields :actor_queries
    import_fields :director_queries
  end

  # mutation do
  #   # mutations go here
  # end

  # subscription do
  #   # subscriptions go here
  # end
end
