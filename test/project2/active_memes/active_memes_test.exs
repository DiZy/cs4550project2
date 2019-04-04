defmodule Project2.ActiveMemesTest do
  use Project2.DataCase

  alias Project2.ActiveMemes

  describe "activememes" do
    alias Project2.ActiveMemes.ActiveMeme

    @valid_attrs %{gif_id: "some gif_id", is_user_created: true, lat: 120.5, long: 120.5}
    @update_attrs %{gif_id: "some updated gif_id", is_user_created: false, lat: 456.7, long: 456.7}
    @invalid_attrs %{gif_id: nil, is_user_created: nil, lat: nil, long: nil}

    def active_meme_fixture(attrs \\ %{}) do
      {:ok, active_meme} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ActiveMemes.create_active_meme()

      active_meme
    end

    test "list_activememes/0 returns all activememes" do
      active_meme = active_meme_fixture()
      assert ActiveMemes.list_activememes() == [active_meme]
    end

    test "get_active_meme!/1 returns the active_meme with given id" do
      active_meme = active_meme_fixture()
      assert ActiveMemes.get_active_meme!(active_meme.id) == active_meme
    end

    test "create_active_meme/1 with valid data creates a active_meme" do
      assert {:ok, %ActiveMeme{} = active_meme} = ActiveMemes.create_active_meme(@valid_attrs)
      assert active_meme.gif_id == "some gif_id"
      assert active_meme.is_user_created == true
      assert active_meme.lat == 120.5
      assert active_meme.long == 120.5
    end

    test "create_active_meme/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ActiveMemes.create_active_meme(@invalid_attrs)
    end

    test "update_active_meme/2 with valid data updates the active_meme" do
      active_meme = active_meme_fixture()
      assert {:ok, %ActiveMeme{} = active_meme} = ActiveMemes.update_active_meme(active_meme, @update_attrs)
      assert active_meme.gif_id == "some updated gif_id"
      assert active_meme.is_user_created == false
      assert active_meme.lat == 456.7
      assert active_meme.long == 456.7
    end

    test "update_active_meme/2 with invalid data returns error changeset" do
      active_meme = active_meme_fixture()
      assert {:error, %Ecto.Changeset{}} = ActiveMemes.update_active_meme(active_meme, @invalid_attrs)
      assert active_meme == ActiveMemes.get_active_meme!(active_meme.id)
    end

    test "delete_active_meme/1 deletes the active_meme" do
      active_meme = active_meme_fixture()
      assert {:ok, %ActiveMeme{}} = ActiveMemes.delete_active_meme(active_meme)
      assert_raise Ecto.NoResultsError, fn -> ActiveMemes.get_active_meme!(active_meme.id) end
    end

    test "change_active_meme/1 returns a active_meme changeset" do
      active_meme = active_meme_fixture()
      assert %Ecto.Changeset{} = ActiveMemes.change_active_meme(active_meme)
    end
  end
end
