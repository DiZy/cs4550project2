defmodule Project2.Repo.Migrations.CreateMemesfound do
  use Ecto.Migration

  def change do
    create table(:memesfound) do
      add :meme_id, references(:usercreatedmemes, on_delete: :nothing)
      add :gif_id, :string
      add :is_user_created, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:memesfound, [:user_id])
  end
end
