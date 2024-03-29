defmodule EmdbWeb.Router do
  use EmdbWeb, :router

  forward "/api", Absinthe.Plug.GraphiQL,
    schema: EmdbWeb.Schema,
    interface: :playground,
    pipeline: {ApolloTracing.Pipeline, :plug}

  forward "/voyager", EmdbWeb.Plugs.GraphQLVoyager
end
