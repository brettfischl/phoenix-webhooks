defmodule Webhooks.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Webhooks.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Webhooks.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  @doc """
  Generate a organization.
  """
  def organization_fixture(attrs \\ %{}) do
    {:ok, organization} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Webhooks.Accounts.create_organization()

    organization
  end

  @doc """
  Generate a user_organization.
  """
  def user_organization_fixture(attrs \\ %{}) do
    {:ok, user_organization} =
      attrs
      |> Enum.into(%{
        is_current: true
      })
      |> Webhooks.Accounts.create_user_organization()

    user_organization
  end
end
