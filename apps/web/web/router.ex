defmodule Web.Router do
  use Web.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BasicAuth, Application.get_env(:web, :basic_auth)
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug BasicAuth, Application.get_env(:web, :basic_auth)
  end

  scope "/", Web do
    pipe_through :browser
  end

  scope "/api", Web do
    pipe_through :api

    resources "/baby_bottles", BabyBottlesController, only: [:create]
    resources "/diapers", DiapersController, only: [:create]

    scope "/stats", Stats do
      scope "/baby_bottles", BabyBottle do
        resources "/daily_consumption", DailyConsumptionController, only: [:show]
      end
    end
  end
end
