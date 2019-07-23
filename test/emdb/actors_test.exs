defmodule Emdb.ActorsTest do
  use Emdb.DataCase

  alias Emdb.Actors

  describe "actors" do
    alias Emdb.Actors.Actor

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def actor_fixture(attrs \\ %{}) do
      {:ok, actor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Actors.create_actor()

      actor
    end

    test "list_actors/0 returns all actors" do
      actor = actor_fixture()
      assert Actors.list_actors() == [actor]
    end

    test "get_actor!/1 returns the actor with given id" do
      actor = actor_fixture()
      assert Actors.get_actor!(actor.id) == actor
    end

    test "create_actor/1 with valid data creates a actor" do
      assert {:ok, %Actor{} = actor} = Actors.create_actor(@valid_attrs)
      assert actor.name == "some name"
    end

    test "create_actor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Actors.create_actor(@invalid_attrs)
    end

    test "update_actor/2 with valid data updates the actor" do
      actor = actor_fixture()
      assert {:ok, %Actor{} = actor} = Actors.update_actor(actor, @update_attrs)
      assert actor.name == "some updated name"
    end

    test "update_actor/2 with invalid data returns error changeset" do
      actor = actor_fixture()
      assert {:error, %Ecto.Changeset{}} = Actors.update_actor(actor, @invalid_attrs)
      assert actor == Actors.get_actor!(actor.id)
    end

    test "delete_actor/1 deletes the actor" do
      actor = actor_fixture()
      assert {:ok, %Actor{}} = Actors.delete_actor(actor)
      assert_raise Ecto.NoResultsError, fn -> Actors.get_actor!(actor.id) end
    end

    test "change_actor/1 returns a actor changeset" do
      actor = actor_fixture()
      assert %Ecto.Changeset{} = Actors.change_actor(actor)
    end
  end

  describe "roles" do
    alias Emdb.Actors.Role

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Actors.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Actors.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Actors.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Actors.create_role(@valid_attrs)
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Actors.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, %Role{} = role} = Actors.update_role(role, @update_attrs)
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Actors.update_role(role, @invalid_attrs)
      assert role == Actors.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Actors.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Actors.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Actors.change_role(role)
    end
  end
end
