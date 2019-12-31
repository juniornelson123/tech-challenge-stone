use Mix.Config

config :financial_system, FinancialSystem.Repo,
  database: "financial_dev",
  username: "user",
  password: "password",
  hostname: "localhost"
