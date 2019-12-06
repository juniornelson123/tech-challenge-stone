defmodule FinancialSystemWeb.ExchangeController do
  use FinancialSystemWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
