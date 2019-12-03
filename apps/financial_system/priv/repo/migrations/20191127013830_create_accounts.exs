defmodule FinancialSystem.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :currency, :string
      add :balance, :integer
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
  end
end
