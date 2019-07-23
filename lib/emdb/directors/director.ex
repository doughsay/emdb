defmodule Emdb.Directors.Director do
  use Ecto.Schema
  import Ecto.Changeset

  schema "directors" do
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
