defmodule Project2Web.UserCreatedMemeView do
  use Project2Web, :view
  alias Project2Web.UserCreatedMemeView

  def render("index.json", %{usercreatedmemes: usercreatedmemes}) do
    %{data: render_many(usercreatedmemes, UserCreatedMemeView, "user_created_meme.json")}
  end

  def render("show.json", %{user_created_meme: user_created_meme}) do
    %{data: render_one(user_created_meme, UserCreatedMemeView, "user_created_meme.json")}
  end

  def render("user_created_meme.json", %{user_created_meme: user_created_meme}) do
    %{id: user_created_meme.id,
      image_url: user_created_meme.image_url,
      text_line_one: user_created_meme.text_line_one,
      text_line_two: user_created_meme.text_line_two}
  end
end
