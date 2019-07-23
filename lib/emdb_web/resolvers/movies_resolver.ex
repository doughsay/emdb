defmodule EmdbWeb.Resolvers.MoviesResolver do
  alias Emdb.Movies

  def movies(_, _, _) do
    {:ok, Movies.list_movies()}
  end

  def movies_for_director(%{id: director_id}, _, _) do
    {:ok, Movies.get_movies_for_director(director_id)}
  end

  def movies_for_actor(%{id: actor_id}, _, _) do
    {:ok, Movies.get_movies_for_actor(actor_id)}
  end
end
