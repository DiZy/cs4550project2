defmodule Project2Web.ActiveMemeController do
  use Project2Web, :controller

  alias Project2.ActiveMemes
  alias Project2.ActiveMemes.ActiveMeme

  action_fallback Project2Web.FallbackController

  def index(conn, _params) do
    activememes = ActiveMemes.list_activememes()

    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(:created, Jason.encode!(%{memes: activememes}))
  end

  def create(conn, %{"active_meme" => active_meme_params}) do
    with {:ok, %ActiveMeme{} = active_meme} <- ActiveMemes.create_active_meme(active_meme_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.active_meme_path(conn, :show, active_meme))
      |> render("show.json", active_meme: active_meme)
    end
  end

  def show(conn, %{"id" => id}) do
    active_meme = ActiveMemes.get_active_meme!(id)
    render(conn, "show.json", active_meme: active_meme)
  end

  def update(conn, %{"id" => id, "active_meme" => active_meme_params}) do
    active_meme = ActiveMemes.get_active_meme!(id)

    with {:ok, %ActiveMeme{} = active_meme} <- ActiveMemes.update_active_meme(active_meme, active_meme_params) do
      render(conn, "show.json", active_meme: active_meme)
    end
  end

  def delete(conn, %{"id" => id}) do
    active_meme = ActiveMemes.get_active_meme!(id)

    with {:ok, %ActiveMeme{}} <- ActiveMemes.delete_active_meme(active_meme) do
      send_resp(conn, :no_content, "")
    end
  end
end
