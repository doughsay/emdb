defmodule EmdbWeb.Resolvers.DirectorsResolver do
  alias Emdb.Directors

  def director(%{director_id: id}, _, _) do
    {:ok, Directors.get_director!(id)}
  end
end
