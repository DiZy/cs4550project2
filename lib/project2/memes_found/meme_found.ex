defmodule Project2.MemesFound.MemeFound do
  use Ecto.Schema
  import Ecto.Changeset

  schema "memesfound" do
    field :is_used_created, :boolean, default: false
    field :meme_id, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(meme_found, attrs) do
    meme_found
    |> cast(attrs, [:meme_id, :is_used_created])
    |> validate_required([:meme_id, :is_used_created])
  end
end
