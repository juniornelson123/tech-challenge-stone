defmodule FinancialSystem.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :value, :integer
      add :account_received_id, references(:accounts, on_delete: :delete_all)
      add :transfer_id, references(:transfers, on_delete: :delete_all)

      timestamps()
    end
  end
end
