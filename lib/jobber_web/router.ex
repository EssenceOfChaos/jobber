defmodule JobberWeb.Router do
  use JobberWeb, :router
  alias JobberWeb.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plug.Authentication
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Plug.EnsureAuthentication
  end

  scope "/", JobberWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/companies", CompanyController, only: [:new, :create, :show, :index]
    resources("/users", UserController, only: [:new, :create, :show, :index])
    resources("/session", SessionController, only: [:create, :new])
  end

  scope "/", JobberWeb do
    pipe_through [:browser, :authenticated]
    resources("/users", UserController, only: [:delete, :edit, :update])
    resources("/session", SessionController, only: [:delete])
  end

  scope "/" do
    pipe_through :api
    forward "/api", Absinthe.Plug, schema: JobberWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: JobberWeb.Schema,
      interface: :simple
  end
end
