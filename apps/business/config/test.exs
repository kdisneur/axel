use Mix.Config

config :business, Business.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "axel_test",
  username: "axel",
  password: "axel",
  host: "localhost",
  port: "5432",
  pool: Ecto.Adapters.SQL.Sandbox

