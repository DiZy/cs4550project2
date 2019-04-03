defmodule Project2.MemesFound do
  @moduledoc """
  The MemesFound context.
  """

  import Ecto.Query, warn: false
  alias Project2.Repo

  alias Project2.MemesFound.MemeFound

  @doc """
  Returns the list of memesfound.

  ## Examples

      iex> list_memesfound()
      [%MemeFound{}, ...]

  """
  def list_memesfound do
    Repo.all(MemeFound)
  end

  @doc """
  Gets a single meme_found.

  Raises `Ecto.NoResultsError` if the Meme found does not exist.

  ## Examples

      iex> get_meme_found!(123)
      %MemeFound{}

      iex> get_meme_found!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meme_found!(id), do: Repo.get!(MemeFound, id)

  @doc """
  Creates a meme_found.

  ## Examples

      iex> create_meme_found(%{field: value})
      {:ok, %MemeFound{}}

      iex> create_meme_found(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_meme_found(attrs \\ %{}) do
    %MemeFound{}
    |> MemeFound.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a meme_found.

  ## Examples

      iex> update_meme_found(meme_found, %{field: new_value})
      {:ok, %MemeFound{}}

      iex> update_meme_found(meme_found, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_meme_found(%MemeFound{} = meme_found, attrs) do
    meme_found
    |> MemeFound.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a MemeFound.

  ## Examples

      iex> delete_meme_found(meme_found)
      {:ok, %MemeFound{}}

      iex> delete_meme_found(meme_found)
      {:error, %Ecto.Changeset{}}

  """
  def delete_meme_found(%MemeFound{} = meme_found) do
    Repo.delete(meme_found)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meme_found changes.

  ## Examples

      iex> change_meme_found(meme_found)
      %Ecto.Changeset{source: %MemeFound{}}

  """
  def change_meme_found(%MemeFound{} = meme_found) do
    MemeFound.changeset(meme_found, %{})
  end
end
