defmodule WebhooksWeb.HookDataLiveTest do
  use WebhooksWeb.ConnCase

  import Phoenix.LiveViewTest
  import Webhooks.HooksFixtures

  @create_attrs %{data: %{}, method: "some method", params: %{}, referrer: "some referrer"}
  @update_attrs %{data: %{}, method: "some updated method", params: %{}, referrer: "some updated referrer"}
  @invalid_attrs %{data: nil, method: nil, params: nil, referrer: nil}

  defp create_hook_data(_) do
    hook_data = hook_data_fixture()
    %{hook_data: hook_data}
  end

  describe "Index" do
    setup [:create_hook_data]

    test "lists all hook_data", %{conn: conn, hook_data: hook_data} do
      {:ok, _index_live, html} = live(conn, Routes.hook_data_index_path(conn, :index))

      assert html =~ "Listing Hook data"
      assert html =~ hook_data.method
    end

    test "saves new hook_data", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.hook_data_index_path(conn, :index))

      assert index_live |> element("a", "New Hook data") |> render_click() =~
               "New Hook data"

      assert_patch(index_live, Routes.hook_data_index_path(conn, :new))

      assert index_live
             |> form("#hook_data-form", hook_data: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#hook_data-form", hook_data: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.hook_data_index_path(conn, :index))

      assert html =~ "Hook data created successfully"
      assert html =~ "some method"
    end

    test "updates hook_data in listing", %{conn: conn, hook_data: hook_data} do
      {:ok, index_live, _html} = live(conn, Routes.hook_data_index_path(conn, :index))

      assert index_live |> element("#hook_data-#{hook_data.id} a", "Edit") |> render_click() =~
               "Edit Hook data"

      assert_patch(index_live, Routes.hook_data_index_path(conn, :edit, hook_data))

      assert index_live
             |> form("#hook_data-form", hook_data: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#hook_data-form", hook_data: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.hook_data_index_path(conn, :index))

      assert html =~ "Hook data updated successfully"
      assert html =~ "some updated method"
    end

    test "deletes hook_data in listing", %{conn: conn, hook_data: hook_data} do
      {:ok, index_live, _html} = live(conn, Routes.hook_data_index_path(conn, :index))

      assert index_live |> element("#hook_data-#{hook_data.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#hook_data-#{hook_data.id}")
    end
  end

  describe "Show" do
    setup [:create_hook_data]

    test "displays hook_data", %{conn: conn, hook_data: hook_data} do
      {:ok, _show_live, html} = live(conn, Routes.hook_data_show_path(conn, :show, hook_data))

      assert html =~ "Show Hook data"
      assert html =~ hook_data.method
    end

    test "updates hook_data within modal", %{conn: conn, hook_data: hook_data} do
      {:ok, show_live, _html} = live(conn, Routes.hook_data_show_path(conn, :show, hook_data))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Hook data"

      assert_patch(show_live, Routes.hook_data_show_path(conn, :edit, hook_data))

      assert show_live
             |> form("#hook_data-form", hook_data: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#hook_data-form", hook_data: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.hook_data_show_path(conn, :show, hook_data))

      assert html =~ "Hook data updated successfully"
      assert html =~ "some updated method"
    end
  end
end
