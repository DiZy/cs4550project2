defmodule Project2.ActiveMemes do
  @moduledoc """
  The ActiveMemes context.
  """

  import Ecto.Query, warn: false
  alias Project2.Repo

  alias Project2.ActiveMemes.ActiveMeme
  alias Project2.UserCreatedMemes.UserCreatedMeme

  @doc """
  Returns the list of activememes.

  ## Examples

      iex> list_activememes()
      [%ActiveMeme{}, ...]

  """
  def list_activememes do
    user_created_query = from mf in ActiveMeme, 
      join: m in UserCreatedMeme,
      where: mf.is_user_created == true and mf.meme_id == m.id,
      select: %{meme: mf, data: m}

    user_created = Repo.all(user_created_query)

    user_created = Enum.map(user_created, fn m -> %{
      is_user_created: true,
      lat: m.meme.lat,
      long: m.meme.long,
      meme_id: m.data.id,
      image_url: m.data.image_url,
      text_line_one: m.data.text_line_one,
      text_line_two: m.data.text_line_two,
    } end)

    from_api_query = from mf in ActiveMeme,
      join: m in UserCreatedMeme,
      where: mf.is_user_created == false

    from_api = Repo.all(from_api_query)

    from_api_gif_ids_only = Enum.map(from_api, fn mf -> mf.gif_id end)

    from_api_gif_ids_only_str = Enum.join(from_api_gif_ids_only, ",")

    api_key = "jnxtU2q5cYGQI5KYbxSMCj5bHRJ46qaU"

    url = "https://api.giphy.com/v1/gifs"
    headers = []
    params = [api_key: api_key, ids: from_api_gif_ids_only_str]

    resp = HTTPoison.get!(url, headers, params: params)

    meme_data = Jason.decode!(resp.body)["data"]

    memes = for {from_db, from_api} <- Enum.zip(from_api, meme_data) do
      %{
        is_user_created: false,
        lat: from_db.lat,
        long: from_db.long,
        gif_id: from_db.gif_id,
        url: from_api["images"]["original"]["url"]
      }
    end

    user_created ++ memes
  end

  @doc """
  Gets a single active_meme.

  Raises `Ecto.NoResultsError` if the Active meme does not exist.

  ## Examples

      iex> get_active_meme!(123)
      %ActiveMeme{}

      iex> get_active_meme!(456)
      ** (Ecto.NoResultsError)

  """
  def get_active_meme!(id), do: Repo.get!(ActiveMeme, id)

  @doc """
  Creates a active_meme.

  ## Examples

      iex> create_active_meme(%{field: value})
      {:ok, %ActiveMeme{}}

      iex> create_active_meme(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_active_meme(attrs \\ %{}) do
    %ActiveMeme{}
    |> ActiveMeme.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a active_meme.

  ## Examples

      iex> update_active_meme(active_meme, %{field: new_value})
      {:ok, %ActiveMeme{}}

      iex> update_active_meme(active_meme, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_active_meme(%ActiveMeme{} = active_meme, attrs) do
    active_meme
    |> ActiveMeme.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ActiveMeme.

  ## Examples

      iex> delete_active_meme(active_meme)
      {:ok, %ActiveMeme{}}

      iex> delete_active_meme(active_meme)
      {:error, %Ecto.Changeset{}}

  """
  def delete_active_meme(%ActiveMeme{} = active_meme) do
    Repo.delete(active_meme)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking active_meme changes.

  ## Examples

      iex> change_active_meme(active_meme)
      %Ecto.Changeset{source: %ActiveMeme{}}

  """
  def change_active_meme(%ActiveMeme{} = active_meme) do
    ActiveMeme.changeset(active_meme, %{})
  end
end
