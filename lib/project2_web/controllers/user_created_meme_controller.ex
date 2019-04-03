defmodule Project2Web.UserCreatedMemeController do
  use Project2Web, :controller

  alias Project2.UserCreatedMemes
  alias Project2.UserCreatedMemes.UserCreatedMeme

  action_fallback Project2Web.FallbackController

  def index(conn, _params) do
    usercreatedmemes = UserCreatedMemes.list_usercreatedmemes()
    render(conn, "index.json", usercreatedmemes: usercreatedmemes)
  end

  def create(conn, %{"user_created_meme" => user_created_meme_params}) do
    with {:ok, %UserCreatedMeme{} = user_created_meme} <- UserCreatedMemes.create_user_created_meme(user_created_meme_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_created_meme_path(conn, :show, user_created_meme))
      |> render("show.json", user_created_meme: user_created_meme)
    end
  end

  def show(conn, %{"id" => id}) do
    user_created_meme = UserCreatedMemes.get_user_created_meme!(id)
    render(conn, "show.json", user_created_meme: user_created_meme)
  end

  def update(conn, %{"id" => id, "user_created_meme" => user_created_meme_params}) do
    user_created_meme = UserCreatedMemes.get_user_created_meme!(id)

    with {:ok, %UserCreatedMeme{} = user_created_meme} <- UserCreatedMemes.update_user_created_meme(user_created_meme, user_created_meme_params) do
      render(conn, "show.json", user_created_meme: user_created_meme)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_created_meme = UserCreatedMemes.get_user_created_meme!(id)

    with {:ok, %UserCreatedMeme{}} <- UserCreatedMemes.delete_user_created_meme(user_created_meme) do
      send_resp(conn, :no_content, "")
    end
  end
end
