defmodule Emdb.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :title, :string
      add :year, :integer
      add :director_id, references(:directors, on_delete: :nothing)

      timestamps()
    end

    create index(:movies, [:director_id])
  end
end
