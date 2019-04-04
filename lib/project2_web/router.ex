defmodule Project2Web.Router do
  use Project2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug Project2.Plugs.FetchSession
  end

  scope "/", Project2Web do
    pipe_through :browser

    get "/", PageController, :index
    
  end

  scope "/api", Project2Web do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/auth", SessionController, only: [:create, :delete]
  end
end
