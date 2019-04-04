defmodule Project2Web.ActiveMemeControllerTest do
  use Project2Web.ConnCase

  alias Project2.ActiveMemes
  alias Project2.ActiveMemes.ActiveMeme

  @create_attrs %{
    gif_id: "some gif_id",
    is_user_created: true,
    lat: 120.5,
    long: 120.5
  }
  @update_attrs %{
    gif_id: "some updated gif_id",
    is_user_created: false,
    lat: 456.7,
    long: 456.7
  }
  @invalid_attrs %{gif_id: nil, is_user_created: nil, lat: nil, long: nil}

  def fixture(:active_meme) do
    {:ok, active_meme} = ActiveMemes.create_active_meme(@create_attrs)
    active_meme
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all activememes", %{conn: conn} do
      conn = get(conn, Routes.active_meme_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create active_meme" do
    test "renders active_meme when data is valid", %{conn: conn} do
      conn = post(conn, Routes.active_meme_path(conn, :create), active_meme: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.active_meme_path(conn, :show, id))

      assert %{
               "id" => id,
               "gif_id" => "some gif_id",
               "is_user_created" => true,
               "lat" => 120.5,
               "long" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.active_meme_path(conn, :create), active_meme: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update active_meme" do
    setup [:create_active_meme]

    test "renders active_meme when data is valid", %{conn: conn, active_meme: %ActiveMeme{id: id} = active_meme} do
      conn = put(conn, Routes.active_meme_path(conn, :update, active_meme), active_meme: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.active_meme_path(conn, :show, id))

      assert %{
               "id" => id,
               "gif_id" => "some updated gif_id",
               "is_user_created" => false,
               "lat" => 456.7,
               "long" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, active_meme: active_meme} do
      conn = put(conn, Routes.active_meme_path(conn, :update, active_meme), active_meme: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete active_meme" do
    setup [:create_active_meme]

    test "deletes chosen active_meme", %{conn: conn, active_meme: active_meme} do
      conn = delete(conn, Routes.active_meme_path(conn, :delete, active_meme))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.active_meme_path(conn, :show, active_meme))
      end
    end
  end

  defp create_active_meme(_) do
    active_meme = fixture(:active_meme)
    {:ok, active_meme: active_meme}
  end
end
