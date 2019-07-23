defmodule EmdbWeb.Resolvers.ActorsResolver do
  alias Emdb.Actors

  def actors_for_movie(%{id: id}, _, _) do
    {:ok, Actors.get_actors_for_movie(id)}
  end
end
