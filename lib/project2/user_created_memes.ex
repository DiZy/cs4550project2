defmodule Project2.UserCreatedMemes do
  @moduledoc """
  The UserCreatedMemes context.
  """

  import Ecto.Query, warn: false
  alias Project2.Repo

  alias Project2.UserCreatedMemes.UserCreatedMeme

  @doc """
  Returns the list of usercreatedmemes.

  ## Examples

      iex> list_usercreatedmemes()
      [%UserCreatedMeme{}, ...]

  """
  def list_usercreatedmemes do
    Repo.all(UserCreatedMeme)
  end

  @doc """
  Gets a single user_created_meme.

  Raises `Ecto.NoResultsError` if the User created meme does not exist.

  ## Examples

      iex> get_user_created_meme!(123)
      %UserCreatedMeme{}

      iex> get_user_created_meme!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_created_meme!(id), do: Repo.get!(UserCreatedMeme, id)

  @doc """
  Creates a user_created_meme.

  ## Examples

      iex> create_user_created_meme(%{field: value})
      {:ok, %UserCreatedMeme{}}

      iex> create_user_created_meme(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_created_meme(attrs \\ %{}) do
    %UserCreatedMeme{}
    |> UserCreatedMeme.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_created_meme.

  ## Examples

      iex> update_user_created_meme(user_created_meme, %{field: new_value})
      {:ok, %UserCreatedMeme{}}

      iex> update_user_created_meme(user_created_meme, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_created_meme(%UserCreatedMeme{} = user_created_meme, attrs) do
    user_created_meme
    |> UserCreatedMeme.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserCreatedMeme.

  ## Examples

      iex> delete_user_created_meme(user_created_meme)
      {:ok, %UserCreatedMeme{}}

      iex> delete_user_created_meme(user_created_meme)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_created_meme(%UserCreatedMeme{} = user_created_meme) do
    Repo.delete(user_created_meme)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_created_meme changes.

  ## Examples

      iex> change_user_created_meme(user_created_meme)
      %Ecto.Changeset{source: %UserCreatedMeme{}}

  """
  def change_user_created_meme(%UserCreatedMeme{} = user_created_meme) do
    UserCreatedMeme.changeset(user_created_meme, %{})
  end
end
