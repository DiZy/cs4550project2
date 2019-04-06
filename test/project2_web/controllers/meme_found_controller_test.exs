defmodule Project2Web.MemeFoundControllerTest do
  use Project2Web.ConnCase

  alias Project2.MemesFound
  alias Project2.MemesFound.MemeFound

  @create_attrs %{
    is_user_created: true,
    meme_id: 42
  }
  @update_attrs %{
    is_user_created: false,
    meme_id: 43
  }
  @invalid_attrs %{is_user_created: nil, meme_id: nil}

  def fixture(:meme_found) do
    {:ok, meme_found} = MemesFound.create_meme_found(@create_attrs)
    meme_found
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all memesfound", %{conn: conn} do
      conn = get(conn, Routes.meme_found_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create meme_found" do
    test "renders meme_found when data is valid", %{conn: conn} do
      conn = post(conn, Routes.meme_found_path(conn, :create), meme_found: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.meme_found_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_user_created" => true,
               "meme_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.meme_found_path(conn, :create), meme_found: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update meme_found" do
    setup [:create_meme_found]

    test "renders meme_found when data is valid", %{conn: conn, meme_found: %MemeFound{id: id} = meme_found} do
      conn = put(conn, Routes.meme_found_path(conn, :update, meme_found), meme_found: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.meme_found_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_user_created" => false,
               "meme_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, meme_found: meme_found} do
      conn = put(conn, Routes.meme_found_path(conn, :update, meme_found), meme_found: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete meme_found" do
    setup [:create_meme_found]

    test "deletes chosen meme_found", %{conn: conn, meme_found: meme_found} do
      conn = delete(conn, Routes.meme_found_path(conn, :delete, meme_found))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.meme_found_path(conn, :show, meme_found))
      end
    end
  end

  defp create_meme_found(_) do
    meme_found = fixture(:meme_found)
    {:ok, meme_found: meme_found}
  end
end
