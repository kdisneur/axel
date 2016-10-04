use Mix.Config

config :business, ecto_repos: [Business.Repo]

import_config "#{Mix.env}.exs"
