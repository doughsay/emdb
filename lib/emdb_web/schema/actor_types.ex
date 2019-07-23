defmodule EmdbWeb.Schema.ActorTypes do
  use Absinthe.Schema.Notation

  @desc "An actor in an 80's movie"
  object :actor do
    field :name, non_null(:string)
  end
end
