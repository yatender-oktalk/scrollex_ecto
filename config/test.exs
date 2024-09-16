import Config

config :scrollex_ecto, ecto_repos: [ScrollexEcto.TestRepo]

config :scrollex_ecto, ScrollexEcto.TestRepo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("SCROLLEX_ECTO_DB_USER") || "postgres",
  password: "postgres",
  database: "scrollex_ecto_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, :console, level: :error
