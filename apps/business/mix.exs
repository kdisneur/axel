defmodule Business.Mixfile do
  use Mix.Project

  def project do
    [app: :business,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [
      mod: {Business, []},
      applications: [
        :ecto,
        :logger,
        :postgrex
      ]
    ]
  end

  defp deps do
    [
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 2.0.0"}
    ]
  end
end
