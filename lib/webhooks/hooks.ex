defmodule Webhooks.Hooks do
  @moduledoc """
  The Hooks context.
  """

  import Ecto.Query, warn: false
  alias Webhooks.Repo

  alias Webhooks.Hooks.Hook

  @doc """
  Returns the list of hooks.

  ## Examples

      iex> list_hooks()
      [%Hook{}, ...]

  """
  def list_hooks do
    Repo.all(Hook)
  end

  @doc """
  Gets a single hook.

  Raises `Ecto.NoResultsError` if the Hook does not exist.

  ## Examples

      iex> get_hook!(123)
      %Hook{}

      iex> get_hook!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hook!(id), do: Repo.get!(Hook, id)

  @doc """
  Creates a hook.

  ## Examples

      iex> create_hook(%{field: value})
      {:ok, %Hook{}}

      iex> create_hook(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hook(attrs \\ %{}) do
    %Hook{}
    |> Hook.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hook.

  ## Examples

      iex> update_hook(hook, %{field: new_value})
      {:ok, %Hook{}}

      iex> update_hook(hook, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hook(%Hook{} = hook, attrs) do
    hook
    |> Hook.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hook.

  ## Examples

      iex> delete_hook(hook)
      {:ok, %Hook{}}

      iex> delete_hook(hook)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hook(%Hook{} = hook) do
    Repo.delete(hook)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hook changes.

  ## Examples

      iex> change_hook(hook)
      %Ecto.Changeset{data: %Hook{}}

  """
  def change_hook(%Hook{} = hook, attrs \\ %{}) do
    Hook.changeset(hook, attrs)
  end

  alias Webhooks.Hooks.HookData

  @doc """
  Returns the list of hook_data.

  ## Examples

      iex> list_hook_data()
      [%HookData{}, ...]

  """
  def list_hook_data do
    Repo.all(HookData)
  end

  @doc """
  Gets a single hook_data.

  Raises `Ecto.NoResultsError` if the Hook data does not exist.

  ## Examples

      iex> get_hook_data!(123)
      %HookData{}

      iex> get_hook_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hook_data!(id), do: Repo.get!(HookData, id)

  @doc """
  Creates a hook_data.

  ## Examples

      iex> create_hook_data(%{field: value})
      {:ok, %HookData{}}

      iex> create_hook_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hook_data(attrs \\ %{}) do
    %HookData{}
    |> HookData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hook_data.

  ## Examples

      iex> update_hook_data(hook_data, %{field: new_value})
      {:ok, %HookData{}}

      iex> update_hook_data(hook_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hook_data(%HookData{} = hook_data, attrs) do
    hook_data
    |> HookData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hook_data.

  ## Examples

      iex> delete_hook_data(hook_data)
      {:ok, %HookData{}}

      iex> delete_hook_data(hook_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hook_data(%HookData{} = hook_data) do
    Repo.delete(hook_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hook_data changes.

  ## Examples

      iex> change_hook_data(hook_data)
      %Ecto.Changeset{data: %HookData{}}

  """
  def change_hook_data(%HookData{} = hook_data, attrs \\ %{}) do
    HookData.changeset(hook_data, attrs)
  end
end
