defmodule Emdb.Repo.Migrations.CreateActors do
  use Ecto.Migration

  def change do
    create table(:actors) do
      add :name, :string

      timestamps()
    end

  end
end
