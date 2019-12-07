defmodule Jobber.Repo.Migrations.AddFavorites do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :favorites, {:array, :string}
    end
  end
end
