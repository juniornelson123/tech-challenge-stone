defmodule FinancialSystemWeb.Api.ExchangeView do
  use FinancialSystemWeb, :view

  def render("exchange.json", %{value: value}) do
    value
  end
end
