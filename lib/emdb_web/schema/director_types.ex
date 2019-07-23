defmodule EmdbWeb.Schema.DirectorTypes do
  use Absinthe.Schema.Notation

  @desc "An 80's movie director"
  object :director do
    field :name, non_null(:string)
  end
end
