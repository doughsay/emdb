# EMDB Presentation Playbook

This is the script to follow during the presentation.

## Initial setup

```bash
# generate a basic phoenix application with no html and no js assets (i.e. API only)
mix phx.new --no-webpack --no-html emdb

# create db and start server
cd emdb
mix ecto.create
iex -S mix phx.server
```

## Data Model

```bash
# generate some contexts & schemas
mix phx.gen.context Directors Director directors name
mix phx.gen.context Movies Movie movies title year:integer director_id:references:directors
mix phx.gen.context Actors Actor actors name
mix phx.gen.context Actors Role roles actor_id:references:actors movie_id:references:movies

mix ecto.migrate
```

## Model Tweaks

```elixir
# lib/emdb/actors/actor.ex

defmodule Emdb.Actors.Actor do
  use Ecto.Schema
  import Ecto.Changeset

  alias Emdb.Actors.Role
  alias Emdb.Movies.Movie

  schema "actors" do
    has_many :roles, Role
    many_to_many :movies, Movie, join_through: Role

    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(actor, attrs) do
    actor
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
```

```elixir
# lib/emdb/actors/role.ex

defmodule Emdb.Actors.Role do
  use Ecto.Schema
  import Ecto.Changeset

  alias Emdb.Actors.Actor
  alias Emdb.Movies.Movie

  schema "roles" do
    belongs_to :actor, Actor
    belongs_to :movie, Movie

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:actor_id, :movie_id])
    |> validate_required([:actor_id, :movie_id])
  end
end
```

```elixir
# lib/emdb/directors/director.ex

defmodule Emdb.Directors.Director do
  use Ecto.Schema
  import Ecto.Changeset

  alias Emdb.Movies.Movie

  schema "directors" do
    has_many :movies, Movie

    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(director, attrs) do
    director
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
```

```elixir
# lib/emdb/movies/movie.ex

defmodule Emdb.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  alias Emdb.Actors.{Actor, Role}
  alias Emdb.Directors.Director

  schema "movies" do
    belongs_to :director, Director
    has_many :roles, Role
    many_to_many :actors, Actor, join_through: Role

    field :title, :string
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :year, :director_id])
    |> validate_required([:title, :year, :director_id])
  end
end
```

## Context & Schema Demonstration

```elixir
# show that we have no movies
Emdb.Movies.list_movies()

# insert a movie into the database
Emdb.Directors.create_director(%{name: "Robert Zemeckis"})
Emdb.Movies.create_movie(%{title: "Back to The Future", director_id: 1, year: 1985})
Emdb.Actors.create_actor(%{name: "Michael J. Fox"})
Emdb.Actors.create_role(%{actor_id: 1, movie_id: 1})

# show that we now have one movie
Emdb.Movies.list_movies()
Emdb.Movies.list_movies() |> Emdb.Repo.preload([:director, :actors])
```

## Installing Absinthe

```elixir
# mix.exs

...

defp deps do
  [
    {:absinthe, "~> 1.4"},
    {:absinthe_plug, "~> 1.4"},
    ...
  ]
end

...
```

```elixir
# lib/emdb_web/router.ex

defmodule EmdbWeb.Router do
  use EmdbWeb, :router

  forward "/api", Absinthe.Plug.GraphiQL,
    schema: EmdbWeb.Schema,
    interface: :playground
end
```

```elixir
# lib/emdb_web/schema.ex

defmodule EmdbWeb.Schema do
  use Absinthe.Schema

  query do
    @desc "Check that the server is running"
    field :health, non_null(:string) do
      resolve fn _, _ -> {:ok, "alive!"} end
    end
  end
end
```

```elixir
# .formatter.exs

[
  import_deps: [:ecto, :phoenix, :absinthe],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"]
]
```

## First Query

```elixir
# lib/emdb_web/schema.ex

defmodule EmdbWeb.Schema do
  use Absinthe.Schema

  alias Emdb.Movies

  @desc "A cool 80's movie"
  object :movie do
    field :title, non_null(:string)
    field :year, non_null(:integer)
  end

  query do
    @desc "List all 80's movies"
    field :movies, non_null(list_of(non_null(:movie))) do
      resolve fn _, _ ->
        {:ok, Movies.list_movies()}
      end
    end
  end
end
```

## Get Organized

```elixir
# lib/emdb_web/resolvers/movies_resolver.ex

defmodule EmdbWeb.Resolvers.MoviesResolver do
  alias Emdb.Movies

  def movies(_, _, _) do
    {:ok, Movies.list_movies()}
  end
end
```

```elixir
# lib/emdb_web/schema/movie_types.ex

defmodule EmdbWeb.Schema.MovieTypes do
  use Absinthe.Schema.Notation

  alias EmdbWeb.Resolvers.MoviesResolver

  @desc "A cool 80's movie"
  object :movie do
    field :title, non_null(:string)
    field :year, non_null(:integer)
  end

  object :movie_queries do
    @desc "List all 80's movies"
    field :movies, non_null(list_of(non_null(:movie))), resolve: &MoviesResolver.movies/3
  end
end
```

```elixir
# lib/emdb_web/schema.ex

defmodule EmdbWeb.Schema do
  use Absinthe.Schema

  import_types EmdbWeb.Schema.MovieTypes

  query do
    import_fields :movie_queries
  end
end
```

## First Assoc Resolver

```elixir
# lib/emdb_web/schema/movie_types.ex

defmodule EmdbWeb.Schema.MovieTypes do
  use Absinthe.Schema.Notation

  alias EmdbWeb.Resolvers.{MoviesResolver, DirectorsResolver}

  import_types EmdbWeb.Schema.DirectorTypes

  @desc "A cool 80's movie"
  object :movie do
    field :title, non_null(:string)
    field :year, non_null(:integer)
    field :director, non_null(:director), resolve: &DirectorsResolver.director/3
  end

  object :movie_queries do
    @desc "List all 80's movies"
    field :movies, non_null(list_of(non_null(:movie))), resolve: &MoviesResolver.movies/3
  end
end
```

```elixir
# lib/emdb_web/schema/director_types.ex

defmodule EmdbWeb.Schema.MovieTypes do
  use Absinthe.Schema.Notation

  @desc "An 80's movie director"
  object :director do
    field :name, non_null(:string)
  end
end
```

```elixir
# lib/emdb_web/resolvers/directors_resolver.ex

defmodule EmdbWeb.Resolvers.DirectorsResolver do
  alias Emdb.Directors

  def director(%{director_id: id}, _, _) do
    {:ok, Directors.get_director!(id)}
  end
end
```

## Needing More Context

```elixir
# lib/emdb/actors.ex

...

alias Emdb.Movies

@doc """
Gets all actors for a given movie id.
"""
def get_actors_for_movie(movie_id) do
  movie = movie_id |> Movies.get_movie!() |> Repo.preload(:actors)
  movie.actors
end

...
```

```elixir
# lib/emdb_web/resolvers/actors_resolver.ex

defmodule EmdbWeb.Resolvers.ActorsResolver do
  alias Emdb.Actors

  def actors_for_movie(%{id: id}, _, _) do
    {:ok, Actors.get_actors_for_movie(id)}
  end
end
```

```elixir
# lib/emdb_web/schema/movie_types.ex

defmodule EmdbWeb.Schema.MovieTypes do
  use Absinthe.Schema.Notation

  alias EmdbWeb.Resolvers.{MoviesResolver, DirectorsResolver, ActorsResolver}

  @desc "A cool 80's movie"
  object :movie do
    field :title, non_null(:string)
    field :year, non_null(:integer)
    field :director, non_null(:director), resolve: &DirectorsResolver.director/3
    field :actors, non_null(list_of(non_null(:actor))), resolve: &ActorsResolver.actors_for_movie/3
  end

  @desc "An 80's movie director"
  object :director do
    field :name, non_null(:string)
  end

  @desc "An actor in an 80's movie"
  object :actor do
    field :name, non_null(:string)
  end

  object :movie_queries do
    @desc "List all 80's movies"
    field :movies, non_null(list_of(non_null(:movie))), resolve: &MoviesResolver.movies/3
  end
end
```
