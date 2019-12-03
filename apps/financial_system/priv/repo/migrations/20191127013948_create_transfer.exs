defmodule FinancialSystem.Repo.Migrations.CreateTransfer do
  use Ecto.Migration

  def change do
    create table(:transfers) do
      add :value, :integer
      add :success, :boolean, default: false
      add :reason, :string
      add :account_id, references(:accounts, on_delete: :delete_all)


      timestamps()
    end
  end
end
