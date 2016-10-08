use Mix.Config

# For production, we configure the host to read the PORT
# from the system environment. Therefore, you will need
# to set PORT=80 before running your server.
#
# You should also configure the url host to something
# meaningful, we use this information when generating URLs.
#
# Finally, we also include the path to a manifest
# containing the digested version of static files. This
# manifest is generated by the mix phoenix.digest task
# which you typically run after static files are built.
config :web, Web.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: {System.get_env("HOST")}, port: {:system, "PORT"}]

config :web, Web.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :web, :basic_auth, [
  realm: "Secured Area",
  username: System.get_env("BASIC_AUTH_USER"),
  password: System.get_env("BASIC_AUTH_PASSWORD")
]

# Do not print debug messages in production
config :logger, level: :info
