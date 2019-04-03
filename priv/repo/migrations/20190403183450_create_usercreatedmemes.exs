defmodule Project2.Repo.Migrations.CreateUsercreatedmemes do
  use Ecto.Migration

  def change do
    create table(:usercreatedmemes) do
      add :image_url, :string
      add :text_line_one, :string
      add :text_line_two, :string

      timestamps()
    end

  end
end
