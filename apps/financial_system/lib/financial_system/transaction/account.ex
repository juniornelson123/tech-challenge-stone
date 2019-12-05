defmodule FinancialSystem.Transaction.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :currency, :string
    field :balance, :integer
    belongs_to :user, FinancialSystem.Transaction.User

    has_many :items, FinancialSystem.Transaction.Item, foreign_key: :account_received_id, on_delete: :delete_all
    has_many :transfers, FinancialSystem.Transaction.Transfer, on_delete: :delete_all

    timestamps()
  end

  def changeset(account, params \\ %{}) do
    account
    |> cast(params, [:currency, :balance, :user_id])
    |> cast_assoc(:user)
    |> validate_required([:currency, :balance])
    |> foreign_key_constraint(:user_id, message: "user invalid")
  end
end
