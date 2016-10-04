defmodule Business do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Business.Repo, []),
    ]

    opts = [strategy: :one_for_one, name: Business.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
