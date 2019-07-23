defmodule EmdbWeb.Schema do
  use Absinthe.Schema

  query do
    @desc "Check that the server is running"
    field :health, non_null(:string) do
      resolve(fn _, _ -> {:ok, "alive!"} end)
    end
  end
end
