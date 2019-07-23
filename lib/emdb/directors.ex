defmodule Emdb.Directors do
  @moduledoc """
  The Directors context.
  """

  import Ecto.Query, warn: false
  alias Emdb.Repo

  alias Emdb.Directors.Director

  @doc """
  Returns the list of directors.

  ## Examples

      iex> list_directors()
      [%Director{}, ...]

  """
  def list_directors do
    Repo.all(Director)
  end

  @doc """
  Gets a single director.

  Raises `Ecto.NoResultsError` if the Director does not exist.

  ## Examples

      iex> get_director!(123)
      %Director{}

      iex> get_director!(456)
      ** (Ecto.NoResultsError)

  """
  def get_director!(id), do: Repo.get!(Director, id)

  @doc """
  Creates a director.

  ## Examples

      iex> create_director(%{field: value})
      {:ok, %Director{}}

      iex> create_director(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_director(attrs \\ %{}) do
    %Director{}
    |> Director.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a director.

  ## Examples

      iex> update_director(director, %{field: new_value})
      {:ok, %Director{}}

      iex> update_director(director, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_director(%Director{} = director, attrs) do
    director
    |> Director.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Director.

  ## Examples

      iex> delete_director(director)
      {:ok, %Director{}}

      iex> delete_director(director)
      {:error, %Ecto.Changeset{}}

  """
  def delete_director(%Director{} = director) do
    Repo.delete(director)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking director changes.

  ## Examples

      iex> change_director(director)
      %Ecto.Changeset{source: %Director{}}

  """
  def change_director(%Director{} = director) do
    Director.changeset(director, %{})
  end
end
