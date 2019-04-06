defmodule Project2.MemesFoundTest do
  use Project2.DataCase

  alias Project2.MemesFound

  describe "memesfound" do
    alias Project2.MemesFound.MemeFound

    @valid_attrs %{is_user_created: true, meme_id: 42}
    @update_attrs %{is_user_created: false, meme_id: 43}
    @invalid_attrs %{is_user_created: nil, meme_id: nil}

    def meme_found_fixture(attrs \\ %{}) do
      {:ok, meme_found} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MemesFound.create_meme_found()

      meme_found
    end

    test "list_memesfound/0 returns all memesfound" do
      meme_found = meme_found_fixture()
      assert MemesFound.list_memesfound() == [meme_found]
    end

    test "get_meme_found!/1 returns the meme_found with given id" do
      meme_found = meme_found_fixture()
      assert MemesFound.get_meme_found!(meme_found.id) == meme_found
    end

    test "create_meme_found/1 with valid data creates a meme_found" do
      assert {:ok, %MemeFound{} = meme_found} = MemesFound.create_meme_found(@valid_attrs)
      assert meme_found.is_user_created == true
      assert meme_found.meme_id == 42
    end

    test "create_meme_found/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MemesFound.create_meme_found(@invalid_attrs)
    end

    test "update_meme_found/2 with valid data updates the meme_found" do
      meme_found = meme_found_fixture()
      assert {:ok, %MemeFound{} = meme_found} = MemesFound.update_meme_found(meme_found, @update_attrs)
      assert meme_found.is_user_created == false
      assert meme_found.meme_id == 43
    end

    test "update_meme_found/2 with invalid data returns error changeset" do
      meme_found = meme_found_fixture()
      assert {:error, %Ecto.Changeset{}} = MemesFound.update_meme_found(meme_found, @invalid_attrs)
      assert meme_found == MemesFound.get_meme_found!(meme_found.id)
    end

    test "delete_meme_found/1 deletes the meme_found" do
      meme_found = meme_found_fixture()
      assert {:ok, %MemeFound{}} = MemesFound.delete_meme_found(meme_found)
      assert_raise Ecto.NoResultsError, fn -> MemesFound.get_meme_found!(meme_found.id) end
    end

    test "change_meme_found/1 returns a meme_found changeset" do
      meme_found = meme_found_fixture()
      assert %Ecto.Changeset{} = MemesFound.change_meme_found(meme_found)
    end
  end
end
