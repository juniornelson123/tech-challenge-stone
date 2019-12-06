defmodule FinancialSystemWeb.ExchangeView do
  use FinancialSystemWeb, :view
  alias FinancialSystem.Money
  alias FinancialSystem.Money.Coin

  def value_currency(value, currency) do
    if !is_nil(value) && !is_nil(currency) do
      Money.get_value(value, currency)
    else
      0
    end
  end

  def list_coins do
    Poison.encode!(Coin.get_coins)
  end
end
