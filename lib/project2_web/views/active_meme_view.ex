defmodule Project2Web.ActiveMemeView do
  use Project2Web, :view
  alias Project2Web.ActiveMemeView

  def render("index.json", %{activememes: activememes}) do
    %{data: render_many(activememes, ActiveMemeView, "active_meme.json")}
  end

  def render("show.json", %{active_meme: active_meme}) do
    %{data: render_one(active_meme, ActiveMemeView, "active_meme.json")}
  end

  def render("active_meme.json", %{active_meme: active_meme}) do
    %{id: active_meme.id,
      lat: active_meme.lat,
      long: active_meme.long,
      is_user_created: active_meme.is_user_created,
      gif_id: active_meme.gif_id}
  end
end
