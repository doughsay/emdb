defmodule EmdbWeb.Router do
  use EmdbWeb, :router

  forward "/api", Absinthe.Plug.GraphiQL,
    schema: EmdbWeb.Schema,
    interface: :playground
end
