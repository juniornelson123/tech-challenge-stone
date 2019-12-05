defmodule FinancialSystemWeb.TransferView do
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
    Coin.get_coins |> Enum.map(fn coin -> [key: coin.name, value: coin.code] end )
  end
end
