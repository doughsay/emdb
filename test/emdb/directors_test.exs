defmodule Emdb.DirectorsTest do
  use Emdb.DataCase

  alias Emdb.Directors

  describe "directors" do
    alias Emdb.Directors.Director

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def director_fixture(attrs \\ %{}) do
      {:ok, director} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directors.create_director()

      director
    end

    test "list_directors/0 returns all directors" do
      director = director_fixture()
      assert Directors.list_directors() == [director]
    end

    test "get_director!/1 returns the director with given id" do
      director = director_fixture()
      assert Directors.get_director!(director.id) == director
    end

    test "create_director/1 with valid data creates a director" do
      assert {:ok, %Director{} = director} = Directors.create_director(@valid_attrs)
      assert director.name == "some name"
    end

    test "create_director/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directors.create_director(@invalid_attrs)
    end

    test "update_director/2 with valid data updates the director" do
      director = director_fixture()
      assert {:ok, %Director{} = director} = Directors.update_director(director, @update_attrs)
      assert director.name == "some updated name"
    end

    test "update_director/2 with invalid data returns error changeset" do
      director = director_fixture()
      assert {:error, %Ecto.Changeset{}} = Directors.update_director(director, @invalid_attrs)
      assert director == Directors.get_director!(director.id)
    end

    test "delete_director/1 deletes the director" do
      director = director_fixture()
      assert {:ok, %Director{}} = Directors.delete_director(director)
      assert_raise Ecto.NoResultsError, fn -> Directors.get_director!(director.id) end
    end

    test "change_director/1 returns a director changeset" do
      director = director_fixture()
      assert %Ecto.Changeset{} = Directors.change_director(director)
    end
  end
end
