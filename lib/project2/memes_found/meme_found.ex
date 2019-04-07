defmodule Project2.MemesFound.MemeFound do
  use Ecto.Schema
  import Ecto.Changeset

  schema "memesfound" do
    field :is_user_created, :boolean, default: false
    field :meme_id, :id
    field :gif_id, :string
    field :user_id, :id, null: false

    timestamps()
  end

  @doc false
  def changeset(meme_found, attrs) do
    meme_found
    |> cast(attrs, [:meme_id, :is_user_created, :gif_id, :user_id])
    |> validate_required([:meme_id, :is_user_created, :gif_id, :user_id])
  end
end
