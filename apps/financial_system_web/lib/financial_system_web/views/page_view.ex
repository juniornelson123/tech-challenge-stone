defmodule FinancialSystemWeb.PageView do
  use FinancialSystemWeb, :view
  alias FinancialSystem.Money

  def value_currency(value, currency) do
    Money.get_value(value, currency)
  end
end
