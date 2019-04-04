defmodule Project2.UserCreatedMemesTest do
  use Project2.DataCase

  alias Project2.UserCreatedMemes

  describe "usercreatedmemes" do
    alias Project2.UserCreatedMemes.UserCreatedMeme

    @valid_attrs %{image_url: "some image_url", text_line_one: "some text_line_one", text_line_two: "some text_line_two"}
    @update_attrs %{image_url: "some updated image_url", text_line_one: "some updated text_line_one", text_line_two: "some updated text_line_two"}
    @invalid_attrs %{image_url: nil, text_line_one: nil, text_line_two: nil}

    def user_created_meme_fixture(attrs \\ %{}) do
      {:ok, user_created_meme} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserCreatedMemes.create_user_created_meme()

      user_created_meme
    end

    test "list_usercreatedmemes/0 returns all usercreatedmemes" do
      user_created_meme = user_created_meme_fixture()
      assert UserCreatedMemes.list_usercreatedmemes() == [user_created_meme]
    end

    test "get_user_created_meme!/1 returns the user_created_meme with given id" do
      user_created_meme = user_created_meme_fixture()
      assert UserCreatedMemes.get_user_created_meme!(user_created_meme.id) == user_created_meme
    end

    test "create_user_created_meme/1 with valid data creates a user_created_meme" do
      assert {:ok, %UserCreatedMeme{} = user_created_meme} = UserCreatedMemes.create_user_created_meme(@valid_attrs)
      assert user_created_meme.image_url == "some image_url"
      assert user_created_meme.text_line_one == "some text_line_one"
      assert user_created_meme.text_line_two == "some text_line_two"
    end

    test "create_user_created_meme/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserCreatedMemes.create_user_created_meme(@invalid_attrs)
    end

    test "update_user_created_meme/2 with valid data updates the user_created_meme" do
      user_created_meme = user_created_meme_fixture()
      assert {:ok, %UserCreatedMeme{} = user_created_meme} = UserCreatedMemes.update_user_created_meme(user_created_meme, @update_attrs)
      assert user_created_meme.image_url == "some updated image_url"
      assert user_created_meme.text_line_one == "some updated text_line_one"
      assert user_created_meme.text_line_two == "some updated text_line_two"
    end

    test "update_user_created_meme/2 with invalid data returns error changeset" do
      user_created_meme = user_created_meme_fixture()
      assert {:error, %Ecto.Changeset{}} = UserCreatedMemes.update_user_created_meme(user_created_meme, @invalid_attrs)
      assert user_created_meme == UserCreatedMemes.get_user_created_meme!(user_created_meme.id)
    end

    test "delete_user_created_meme/1 deletes the user_created_meme" do
      user_created_meme = user_created_meme_fixture()
      assert {:ok, %UserCreatedMeme{}} = UserCreatedMemes.delete_user_created_meme(user_created_meme)
      assert_raise Ecto.NoResultsError, fn -> UserCreatedMemes.get_user_created_meme!(user_created_meme.id) end
    end

    test "change_user_created_meme/1 returns a user_created_meme changeset" do
      user_created_meme = user_created_meme_fixture()
      assert %Ecto.Changeset{} = UserCreatedMemes.change_user_created_meme(user_created_meme)
    end
  end
end
