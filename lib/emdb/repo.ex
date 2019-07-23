defmodule Emdb.Repo do
  use Ecto.Repo,
    otp_app: :emdb,
    adapter: Ecto.Adapters.Postgres
end
