defmodule Project2Web.UserCreatedMemeControllerTest do
  use Project2Web.ConnCase

  alias Project2.UserCreatedMemes
  alias Project2.UserCreatedMemes.UserCreatedMeme

  @create_attrs %{
    image_url: "some image_url",
    text_line_one: "some text_line_one",
    text_line_two: "some text_line_two"
  }
  @update_attrs %{
    image_url: "some updated image_url",
    text_line_one: "some updated text_line_one",
    text_line_two: "some updated text_line_two"
  }
  @invalid_attrs %{image_url: nil, text_line_one: nil, text_line_two: nil}

  def fixture(:user_created_meme) do
    {:ok, user_created_meme} = UserCreatedMemes.create_user_created_meme(@create_attrs)
    user_created_meme
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all usercreatedmemes", %{conn: conn} do
      conn = get(conn, Routes.user_created_meme_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_created_meme" do
    test "renders user_created_meme when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_created_meme_path(conn, :create), user_created_meme: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_created_meme_path(conn, :show, id))

      assert %{
               "id" => id,
               "image_url" => "some image_url",
               "text_line_one" => "some text_line_one",
               "text_line_two" => "some text_line_two"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_created_meme_path(conn, :create), user_created_meme: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_created_meme" do
    setup [:create_user_created_meme]

    test "renders user_created_meme when data is valid", %{conn: conn, user_created_meme: %UserCreatedMeme{id: id} = user_created_meme} do
      conn = put(conn, Routes.user_created_meme_path(conn, :update, user_created_meme), user_created_meme: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_created_meme_path(conn, :show, id))

      assert %{
               "id" => id,
               "image_url" => "some updated image_url",
               "text_line_one" => "some updated text_line_one",
               "text_line_two" => "some updated text_line_two"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_created_meme: user_created_meme} do
      conn = put(conn, Routes.user_created_meme_path(conn, :update, user_created_meme), user_created_meme: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_created_meme" do
    setup [:create_user_created_meme]

    test "deletes chosen user_created_meme", %{conn: conn, user_created_meme: user_created_meme} do
      conn = delete(conn, Routes.user_created_meme_path(conn, :delete, user_created_meme))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_created_meme_path(conn, :show, user_created_meme))
      end
    end
  end

  defp create_user_created_meme(_) do
    user_created_meme = fixture(:user_created_meme)
    {:ok, user_created_meme: user_created_meme}
  end
end
