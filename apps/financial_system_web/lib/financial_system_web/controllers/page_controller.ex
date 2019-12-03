defmodule FinancialSystemWeb.PageController do
  use FinancialSystemWeb, :controller
  alias FinancialSystem.Transaction
  alias FinancialSystem.Repo

  def index(conn, _params) do
    accounts = Transaction.list_accounts |> Repo.preload([:user])
    render(conn, "index.html", %{ accounts: accounts })
  end
end
