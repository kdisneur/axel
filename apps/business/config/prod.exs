use Mix.Config

config :business, Business.Repo,
  adapter: Ecto.Adapters.Postgres,
  ssl: true,
  url: {:system, "DATABASE_URL"}
