defmodule Project2Web.MemeFoundController do
  use Project2Web, :controller

  alias Project2.MemesFound
  alias Project2.MemesFound.MemeFound

  action_fallback Project2Web.FallbackController

  # My Memes
  def index(conn, %{"user_id" => user_id}) do
    memes = MemesFound.memes_for_user(user_id)
    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(:created, Poison.encode!(%{memes: memes}))
  end

  def create(conn, payload) do
    with {:ok, %MemeFound{} = meme_found} <- MemesFound.create_meme_found(payload) do
      conn
      |> put_resp_header("content-type", "application/json; charset=utf-8")
      |> send_resp(:created, %{meme_found: meme_found})
    end
  end

  def show(conn, %{"id" => id}) do
    meme_found = MemesFound.get_meme_found!(id)
    render(conn, "show.json", meme_found: meme_found)
  end

  def update(conn, %{"id" => id, "meme_found" => meme_found_params}) do
    meme_found = MemesFound.get_meme_found!(id)

    with {:ok, %MemeFound{} = meme_found} <- MemesFound.update_meme_found(meme_found, meme_found_params) do
      render(conn, "show.json", meme_found: meme_found)
    end
  end

  def delete(conn, %{"id" => id}) do
    meme_found = MemesFound.get_meme_found!(id)

    with {:ok, %MemeFound{}} <- MemesFound.delete_meme_found(meme_found) do
      send_resp(conn, :no_content, "")
    end
  end
end
