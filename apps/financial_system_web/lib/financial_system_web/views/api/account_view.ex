defmodule FinancialSystemWeb.Api.AccountView do
  use FinancialSystemWeb, :view

  def render("index.json", %{accounts: accounts}) do
    render_many(accounts, FinancialSystemWeb.Api.AccountView, "account.json")
  end

  def render("account.json", %{account: account}) do
    account
  end
end
