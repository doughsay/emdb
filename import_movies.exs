# Copy paste the below directly into an iex shell running emdb to import some movies

alias Emdb.{Actors, Directors, Movies}
alias Emdb.Repo
import Ecto.Query

stream = File.stream!("movies.csv") |> CSV.decode!() |> Stream.drop(1)

Enum.each(stream, fn row ->
  [
    title,
    year,
    rated,
    released,
    runtime,
    genre,
    director,
    writer,
    actors,
    plot,
    language,
    country,
    awards,
    poster,
    ratings_source,
    ratings_value,
    metascore,
    imdb_rating,
    imdb_votes,
    imdb_id,
    type,
    dvd,
    box_office,
    production,
    website,
    response,
    tomato_url
  ] = row

  case year |> String.trim() |> Integer.parse() do
    {year, ""} ->
      if year >= 1980 and year <= 1989 do
        title = String.trim(title)
        actors = actors |> String.split(", ") |> Enum.map(&String.trim/1)
        director = String.trim(director)

        director =
          case from(d in Directors.Director, where: d.name == ^director) |> Repo.one() do
            nil ->
              {:ok, director} = Directors.create_director(%{name: director})
              director

            director ->
              director
          end

        movie =
          case from(m in Movies.Movie, where: m.title == ^title) |> Repo.one() do
            nil ->
              {:ok, movie} =
                Movies.create_movie(%{title: title, director_id: director.id, year: year})

              movie

            movie ->
              movie
          end

        actors =
          Enum.map(actors, fn actor ->
            case from(a in Actors.Actor, where: a.name == ^actor) |> Repo.one() do
              nil ->
                {:ok, actor} = Actors.create_actor(%{name: actor})
                actor

              actor ->
                actor
            end
          end)

        movie_id = movie.id

        Enum.map(actors, fn actor ->
          actor_id = actor.id

          case from(r in Actors.Role, where: r.actor_id == ^actor_id and r.movie_id == ^movie_id)
               |> Repo.one() do
            nil ->
              {:ok, role} = Actors.create_role(%{actor_id: actor_id, movie_id: movie_id})

            role ->
              :noop
          end
        end)
      end

    _else ->
      :noop
  end
end)
