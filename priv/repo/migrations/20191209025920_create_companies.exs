defmodule Jobber.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :logo, :string
      add :year_founded, :string
      add :industry, :string
    end
  end
end
