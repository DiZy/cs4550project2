defmodule Project2Web.MemeFoundView do
  use Project2Web, :view
  alias Project2Web.MemeFoundView

  def render("index.json", %{memesfound: memesfound}) do
    %{data: render_many(memesfound, MemeFoundView, "meme_found.json")}
  end

  def render("show.json", %{meme_found: meme_found}) do
    %{data: render_one(meme_found, MemeFoundView, "meme_found.json")}
  end

  def render("meme_found.json", %{meme_found: meme_found}) do
    %{id: meme_found.id,
      meme_id: meme_found.meme_id,
      is_user_created: meme_found.is_user_created}
  end
end
