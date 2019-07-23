defmodule EmdbWeb.Resolvers.DirectorsResolver do
  alias Emdb.Directors

  def directors(_, %{search_term: search_term}, _) do
    {:ok, Directors.search_directors(search_term)}
  end

  def director(%{director_id: id}, _, _) do
    {:ok, Directors.get_director!(id)}
  end
end
