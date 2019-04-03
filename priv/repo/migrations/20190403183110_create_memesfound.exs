defmodule Project2.Repo.Migrations.CreateMemesfound do
  use Ecto.Migration

  def change do
    create table(:memesfound) do
      add :meme_id, :integer
      add :is_used_created, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:memesfound, [:user_id])
  end
end
