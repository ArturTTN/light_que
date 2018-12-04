defmodule Pg.Repo do
    use Ecto.Repo,
    otp_app: :pg,
    adapter: Ecto.Adapters.Postgres
end