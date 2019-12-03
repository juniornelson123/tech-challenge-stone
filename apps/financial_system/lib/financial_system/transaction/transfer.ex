defmodule FinancialSystem.Transaction.Transfer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transfers" do
    field :value, :integer
    field :success, :boolean
    field :reason, :string
    belongs_to :account, FinancialSystem.Transaction.Account

    has_many :items, FinancialSystem.Transaction.Item, on_delete: :delete_all

    timestamps()
  end

  def changeset(transfer, params \\ %{}) do
    transfer
    |> cast(params, [:value, :reason, :success, :account_id])
    |> validate_required([:value, :reason, :account_id])
    |> foreign_key_constraint(:account_id, message: "account invalid")
  end

end
