defmodule ProjetoWeb.Repo do
  use Ecto.Repo,
    otp_app: :projeto_web,
    adapter: Ecto.Adapters.Postgres
end
