defmodule Emdb.Repo.Migrations.CreateDirectors do
  use Ecto.Migration

  def change do
    create table(:directors) do
      add :name, :string

      timestamps()
    end

  end
end
