defmodule Scaffold.Repo do
  use Ecto.Repo,
    otp_app: :scaffold,
    adapter: Ecto.Adapters.Postgres
end
