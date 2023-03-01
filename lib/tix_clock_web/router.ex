defmodule TixClockWeb.Router do
  use TixClockWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TixClockWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", TixClockWeb do
    pipe_through :browser

    live "/", Home
  end
end
