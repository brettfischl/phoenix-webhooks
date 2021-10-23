defmodule Webhooks.HooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Webhooks.Hooks` context.
  """

  @doc """
  Generate a hook.
  """
  def hook_fixture(attrs \\ %{}) do
    {:ok, hook} =
      attrs
      |> Enum.into(%{
        path: "some path"
      })
      |> Webhooks.Hooks.create_hook()

    hook
  end

  @doc """
  Generate a hook_data.
  """
  def hook_data_fixture(attrs \\ %{}) do
    {:ok, hook_data} =
      attrs
      |> Enum.into(%{
        data: %{},
        method: "some method",
        params: %{},
        referrer: "some referrer"
      })
      |> Webhooks.Hooks.create_hook_data()

    hook_data
  end
end
