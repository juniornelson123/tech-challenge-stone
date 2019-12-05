defmodule FinancialSystemWeb.Api.TransferController do
  use FinancialSystemWeb, :controller
  alias FinancialSystem.Transaction.Transfer
  alias FinancialSystem.Transaction
  alias FinancialSystem.Repo

  def create(conn, %{"account_id" => account_id, "transfer" => transfer_params}) do
    transfer_params = transfer_params |> Enum.map(fn item -> %{account_received_id: item["account_id"], value: item["value"]} end)

    case FinancialSystem.transfer(account_id, transfer_params) do
      {:ok, transfer} ->
        conn
        |> render("transfer.json", transfer: transfer)
      {:error, transfer} ->
        conn
        |> render("transfer.json", transfer: transfer)
      {:error, changeset} ->
        conn
        |> render("errors.json", changeset: changeset)
    end
  end
end
