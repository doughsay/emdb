defmodule EmdbWeb.Resolvers.MoviesResolver do
  alias Emdb.Movies

  def movies(_, _, _) do
    {:ok, Movies.list_movies()}
  end
end
