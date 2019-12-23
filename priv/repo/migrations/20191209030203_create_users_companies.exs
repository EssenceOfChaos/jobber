defmodule Jobber.Repo.Migrations.CreateUsersCompanies do
  use Ecto.Migration

  def change do
    create table(:users_companies) do
      add :user_id, references(:users)
      add :company_id, references(:companies)
    end

    create unique_index(:users_companies, [:user_id, :company_id])
  end
end
