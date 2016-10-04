use Mix.Config

config :business, Business.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "axel_dev",
  username: "axel",
  password: "axel",
  host: "localhost",
  port: "5432"
