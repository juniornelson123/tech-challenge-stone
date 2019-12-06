defmodule FinancialSystemWeb.Api.ExchangeController do
  use FinancialSystemWeb, :controller
  alias FinancialSystem.Money

  def create(conn, %{"currency_from" => currency_from, "currency_to" => currency_to, "value" => value}) do
    {:ok, exchange} = FinancialSystem.convert(currency_from, currency_to, Money.parse_value(value, currency_from))
    render(conn, "exchange.json", value: Money.get_value(exchange, currency_to))
  end

end
