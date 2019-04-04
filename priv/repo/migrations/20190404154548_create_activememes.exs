defmodule Project2.Repo.Migrations.CreateActivememes do
  use Ecto.Migration

  def change do
    create table(:activememes) do
      add :lat, :float
      add :long, :float
      add :is_user_created, :boolean, default: false, null: false
      add :gif_id, :string
      add :meme_id, references(:usercreatedmemes, on_delete: :nothing)

      timestamps()
    end

    create index(:activememes, [:meme_id])
  end
end
