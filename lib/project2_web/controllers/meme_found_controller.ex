defmodule Project2Web.MemeFoundController do
  use Project2Web, :controller

  alias Project2.MemesFound
  alias Project2.MemesFound.MemeFound

  action_fallback Project2Web.FallbackController

  def index(conn, _params) do
    memesfound = MemesFound.list_memesfound()
    render(conn, "index.json", memesfound: memesfound)
  end

  def create(conn, %{"meme_found" => meme_found_params}) do
    with {:ok, %MemeFound{} = meme_found} <- MemesFound.create_meme_found(meme_found_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.meme_found_path(conn, :show, meme_found))
      |> render("show.json", meme_found: meme_found)
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
