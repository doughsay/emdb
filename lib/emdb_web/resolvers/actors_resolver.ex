defmodule EmdbWeb.Resolvers.ActorsResolver do
  alias Emdb.Actors

  def actors(_, %{search_term: search_term}, _) do
    {:ok, Actors.search_actors(search_term)}
  end

  def actors_for_movie(%{id: id}, _, _) do
    {:ok, Actors.get_actors_for_movie(id)}
  end
end
