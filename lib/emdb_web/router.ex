defmodule EmdbWeb.Router do
  use EmdbWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EmdbWeb do
    pipe_through :api
  end
end
