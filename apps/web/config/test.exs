use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :web, Web.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

config :web, :basic_auth, [
  realm: "Secured Area",
  username: "admin",
  password: "admin"
]
