defmodule ScrollexEcto.TestRepo do
  use Ecto.Repo,
    otp_app: :scrollex_ecto,
    adapter: Ecto.Adapters.Postgres

  use ScrollexEcto
end
