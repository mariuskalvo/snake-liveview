defmodule Snake.Repo do
  use Ecto.Repo,
    otp_app: :snake,
    adapter: Ecto.Adapters.Postgres
end
