defmodule FinancialSystemWeb.Router do
  use FinancialSystemWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FinancialSystemWeb do
    pipe_through :browser

    get "/", AccountController, :index
    resources "/accounts", AccountController do
      resources "/transfers", TransferController
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", FinancialSystemWeb.Api, as: :api do
    pipe_through :api

    resources "/accounts", AccountController, only: [:index]
    resources "/transfers", AccountController, only: [:create]
  end
end
