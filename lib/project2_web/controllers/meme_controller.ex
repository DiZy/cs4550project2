defmodule Project2Web.MemeController do
  use Project2Web, :controller

  import Ecto.Query, warn: false
  alias Project2.Repo

  alias Project2.MemesFound.MemeFound
  alias Project2.UserCreatedMemes.UserCreatedMeme
  alias Project2.ActiveMemes.ActiveMeme

  def index(conn, _params) do
    resp = %{}
    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(:created, Jason.encode!(resp))
  end

  def addmeme(conn, params) do
    #params: is_user_created, lat, long, text_line_one?, text_line_two?, image_url?, gif_id?, 
    user_id = conn.assigns[:user_id]
    if params["is_user_created"] do
      user_created_meme = %UserCreatedMeme{
        text_line_one: params["text_line_one"],
        text_line_two: params["text_line_two"],
        image_url: params["image_url"],
      }

      {:ok, added_meme_id} = Repo.insert!(user_created_meme, returning: :id)

      meme = %MemeFound{
        user_id: user_id,
        meme_id: added_meme_id,
        is_user_created: true
      }

      {:ok, _} = Repo.insert!(meme)

      active_meme = %ActiveMeme{
        is_user_created: true,
        lat: params["lat"],
        long: params["long"],
        meme_id: added_meme_id
      }

      {:ok, _} = Repo.insert!(active_meme)

      resp = %{new_active_meme: active_meme}
      conn
      |> put_resp_header("content-type", "application/json; charset=utf-8")
      |> send_resp(:created, Jason.encode!(resp))
    else
      meme = %MemeFound{
        user_id: user_id,
        gif_id: params["gif_id"],
        is_user_created: false
      }

      {:ok, _} = Repo.insert!(meme)

      active_meme = %ActiveMeme{
        is_user_created: false,
        lat: params["lat"],
        long: params["long"],
        gif_id: params["gif_id"]
      }

      {:ok, _} = Repo.insert!(active_meme)

      resp = %{new_active_meme: active_meme}
      conn
      |> put_resp_header("content-type", "application/json; charset=utf-8")
      |> send_resp(:created, Jason.encode!(resp))
    end
  end

  def getgifs(conn, _params) do
    api_key = "jnxtU2q5cYGQI5KYbxSMCj5bHRJ46qaU"

    url = "https://api.giphy.com/v1/gifs/search"
    headers = []
    params = [api_key: api_key, q: "memes"]

    resp = HTTPoison.get!(url, headers, params: params)
    
    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(:created, resp.body)
  end
end
