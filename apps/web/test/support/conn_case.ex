defmodule Web.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest

      alias Web.Repo

      import Web.Router.Helpers

      @endpoint Web.Endpoint

      @username Application.get_env(:web, :basic_auth)[:username]
      @password Application.get_env(:web, :basic_auth)[:password]

      def using_basic_auth(conn), do: using_basic_auth(conn, @username, @password)

      def using_basic_auth(conn, username, password) do
        header_content = "Basic " <> Base.encode64("#{username}:#{password}")
        put_req_header(conn, "authorization", header_content)
      end
    end
  end

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Business.Repo)

    {:ok, conn: Phoenix.ConnTest.build_conn}
  end
end
