defmodule Project2.UserCreatedMemes.UserCreatedMeme do
  use Ecto.Schema
  import Ecto.Changeset

  schema "usercreatedmemes" do
    field :image_url, :string
    field :text_line_one, :string
    field :text_line_two, :string

    timestamps()
  end

  @doc false
  def changeset(user_created_meme, attrs) do
    user_created_meme
    |> cast(attrs, [:image_url, :text_line_one, :text_line_two])
    |> validate_required([:image_url, :text_line_one, :text_line_two])
  end
end
