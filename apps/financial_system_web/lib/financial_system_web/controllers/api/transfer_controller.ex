defmodule FinancialSystemWeb.Api.TransferController do
  use FinancialSystemWeb, :controller
  alias FinancialSystem.Transaction.Transfer
  alias FinancialSystem.Transaction
  alias FinancialSystem.Repo

  def create(conn, %{"account_id" => account_id, "transfer" => transfer_params}) do

    case FinancialSystem.transfer(account_id, transfer_params) do
      {:ok, transfer} ->
        conn
        |> render("transfer.json", transfer: transfer)
      {:error, changeset} ->
        conn
        |> render("errors.json", changeset: changeset)
    end
  end
end
