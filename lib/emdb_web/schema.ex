defmodule EmdbWeb.Schema do
  use Absinthe.Schema

  alias Emdb.Movies

  @desc "A cool 80's movie"
  object :movie do
    field :title, non_null(:string)
    field :year, non_null(:integer)
  end

  query do
    @desc "Check that the server is running"
    field :health, non_null(:string) do
      resolve fn _, _ -> {:ok, "alive!"} end
    end

    @desc "List all 80's movies"
    field :movies, non_null(list_of(non_null(:movie))) do
      resolve fn _, _ ->
        {:ok, Movies.list_movies()}
      end
    end
  end
end
