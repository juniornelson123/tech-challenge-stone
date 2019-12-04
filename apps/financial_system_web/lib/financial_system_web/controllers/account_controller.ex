defmodule FinancialSystemWeb.AccountController do
  use FinancialSystemWeb, :controller
  alias FinancialSystem.Transaction.Account
  alias FinancialSystem.Money
  alias FinancialSystem.Transaction
  alias FinancialSystem.Repo

  def index(conn, _params) do
    accounts = Transaction.list_accounts |> Repo.preload([:user])
    render(conn, "index.html", accounts: accounts)
  end

  def new(conn, _params) do
    changeset = Transaction.change_account(%Account{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"account" => account_params}) do
    account_params = account_params |> get_balance_value
    case Transaction.create_account(account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Account save")
        |> redirect(to: Routes.account_path(conn, :show, account))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Transaction.get_account!(id) |> Repo.preload([:user])
    render(conn, "show.html", account: account)
  end

  def edit(conn, %{"id" => id}) do
    account = Transaction.get_account!(id) |> Repo.preload([:user])
    changeset  = Transaction.change_account(account)
    render(conn, "edit.html", account: account, changeset: changeset)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Transaction.get_account!(id) |> Repo.preload([:user])
    account_params = account_params |> get_balance_value
    case Transaction.update_account(account, account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Account save")
        |> redirect(to: Routes.account_path(conn, :show, account))
      {:error, changeset} ->
        render(conn, "edit.html", account: account, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Transaction.get_account!(id)
    {:ok, _account} = Transaction.delete_account(account)

    conn
    |> put_flash(:info, "Account deleted successfully.")
    |> redirect(to: Routes.account_path(conn, :index))
  end

  defp get_balance_value(account_params) do
    {value, _} = Float.parse(account_params["balance"])
    Map.put(account_params, "balance", Money.parse_value(value, account_params["currency"]))
  end
end
