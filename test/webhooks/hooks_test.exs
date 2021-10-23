defmodule Webhooks.HooksTest do
  use Webhooks.DataCase

  alias Webhooks.Hooks

  describe "hooks" do
    alias Webhooks.Hooks.Hook

    import Webhooks.HooksFixtures

    @invalid_attrs %{path: nil}

    test "list_hooks/0 returns all hooks" do
      hook = hook_fixture()
      assert Hooks.list_hooks() == [hook]
    end

    test "get_hook!/1 returns the hook with given id" do
      hook = hook_fixture()
      assert Hooks.get_hook!(hook.id) == hook
    end

    test "create_hook/1 with valid data creates a hook" do
      valid_attrs = %{path: "some path"}

      assert {:ok, %Hook{} = hook} = Hooks.create_hook(valid_attrs)
      assert hook.path == "some path"
    end

    test "create_hook/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hooks.create_hook(@invalid_attrs)
    end

    test "update_hook/2 with valid data updates the hook" do
      hook = hook_fixture()
      update_attrs = %{path: "some updated path"}

      assert {:ok, %Hook{} = hook} = Hooks.update_hook(hook, update_attrs)
      assert hook.path == "some updated path"
    end

    test "update_hook/2 with invalid data returns error changeset" do
      hook = hook_fixture()
      assert {:error, %Ecto.Changeset{}} = Hooks.update_hook(hook, @invalid_attrs)
      assert hook == Hooks.get_hook!(hook.id)
    end

    test "delete_hook/1 deletes the hook" do
      hook = hook_fixture()
      assert {:ok, %Hook{}} = Hooks.delete_hook(hook)
      assert_raise Ecto.NoResultsError, fn -> Hooks.get_hook!(hook.id) end
    end

    test "change_hook/1 returns a hook changeset" do
      hook = hook_fixture()
      assert %Ecto.Changeset{} = Hooks.change_hook(hook)
    end
  end

  describe "hook_data" do
    alias Webhooks.Hooks.HookData

    import Webhooks.HooksFixtures

    @invalid_attrs %{data: nil, method: nil, params: nil, referrer: nil}

    test "list_hook_data/0 returns all hook_data" do
      hook_data = hook_data_fixture()
      assert Hooks.list_hook_data() == [hook_data]
    end

    test "get_hook_data!/1 returns the hook_data with given id" do
      hook_data = hook_data_fixture()
      assert Hooks.get_hook_data!(hook_data.id) == hook_data
    end

    test "create_hook_data/1 with valid data creates a hook_data" do
      valid_attrs = %{data: %{}, method: "some method", params: %{}, referrer: "some referrer"}

      assert {:ok, %HookData{} = hook_data} = Hooks.create_hook_data(valid_attrs)
      assert hook_data.data == %{}
      assert hook_data.method == "some method"
      assert hook_data.params == %{}
      assert hook_data.referrer == "some referrer"
    end

    test "create_hook_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hooks.create_hook_data(@invalid_attrs)
    end

    test "update_hook_data/2 with valid data updates the hook_data" do
      hook_data = hook_data_fixture()
      update_attrs = %{data: %{}, method: "some updated method", params: %{}, referrer: "some updated referrer"}

      assert {:ok, %HookData{} = hook_data} = Hooks.update_hook_data(hook_data, update_attrs)
      assert hook_data.data == %{}
      assert hook_data.method == "some updated method"
      assert hook_data.params == %{}
      assert hook_data.referrer == "some updated referrer"
    end

    test "update_hook_data/2 with invalid data returns error changeset" do
      hook_data = hook_data_fixture()
      assert {:error, %Ecto.Changeset{}} = Hooks.update_hook_data(hook_data, @invalid_attrs)
      assert hook_data == Hooks.get_hook_data!(hook_data.id)
    end

    test "delete_hook_data/1 deletes the hook_data" do
      hook_data = hook_data_fixture()
      assert {:ok, %HookData{}} = Hooks.delete_hook_data(hook_data)
      assert_raise Ecto.NoResultsError, fn -> Hooks.get_hook_data!(hook_data.id) end
    end

    test "change_hook_data/1 returns a hook_data changeset" do
      hook_data = hook_data_fixture()
      assert %Ecto.Changeset{} = Hooks.change_hook_data(hook_data)
    end
  end
end
