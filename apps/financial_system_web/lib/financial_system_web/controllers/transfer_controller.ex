defmodule FinancialSystemWeb.TransferController do
  use FinancialSystemWeb, :controller
  alias FinancialSystem.Transaction.Transfer
  alias FinancialSystem.Money
  alias FinancialSystem.Transaction
  alias FinancialSystem.Repo

  def index(conn, %{"account_id" => account_id}) do
    account = Transaction.get_account! account_id
    transfers = Transaction.list_transfers(account_id) |> Repo.preload([[account: :user], [items: [account_received: :user]]])
    render(conn, "index.html", transfers: transfers, account: account)
  end

  def new(conn, %{"account_id" => account_id}) do
    account = Transaction.get_account! account_id
    changeset = Transaction.change_transfer(%Transfer{})
    render(conn, "new.html", changeset: changeset, account: account)
  end

  def create(conn, %{"transfer" => transfer_params, "account_id" => account_id}) do
    # case Transaction.create_account(account_params) do
    #   {:ok, account} ->
    #     conn
    #     |> put_flash(:info, "Account save")
    #     |> redirect(to: Routes.account_path(conn, :show, account))
    #   {:error, changeset} ->
    #     IO.inspect changeset
    #     render(conn, "new.html", changeset: changeset)
    # end
  end
end
