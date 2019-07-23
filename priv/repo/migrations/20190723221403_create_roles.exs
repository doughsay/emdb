defmodule Emdb.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :actor_id, references(:actors, on_delete: :nothing)
      add :movie_id, references(:movies, on_delete: :nothing)

      timestamps()
    end

    create index(:roles, [:actor_id])
    create index(:roles, [:movie_id])
  end
end
