defmodule Project2.ActiveMemes.ActiveMeme do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activememes" do
    field :gif_id, :string
    field :is_user_created, :boolean, default: false
    field :lat, :float
    field :long, :float
    field :meme_id, :id

    timestamps()
  end

  @doc false
  def changeset(active_meme, attrs) do
    active_meme
    |> cast(attrs, [:lat, :long, :is_user_created, :gif_id])
    |> validate_required([:lat, :long, :is_user_created, :gif_id])
  end
end
