defmodule FinancialSystemWeb.Api.AccountController do
  use FinancialSystemWeb, :controller
  alias FinancialSystem.Transaction.Account
  alias FinancialSystem.Transaction
  alias FinancialSystem.Repo

  def index(conn, _params) do
    accounts = Transaction.list_accounts |> Repo.preload([:user])

    render(conn, "index.json", accounts: accounts)
  end
end
