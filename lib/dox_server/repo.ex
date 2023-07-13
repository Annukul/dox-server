defmodule DoxServer.Repo do
  use Ecto.Repo,
    otp_app: :dox_server,
    adapter: Ecto.Adapters.Postgres
end
