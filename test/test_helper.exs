ExUnit.start()

# Load the app
Application.load(:scrollex_ecto)

for repo <- Application.fetch_env!(:scrollex_ecto, :ecto_repos) do
  # Start the repo
  {:ok, _} = repo.start_link(pool_size: 5)

  # Run migrations
  path = Path.join(["priv", "repo", "migrations"])
  Ecto.Migrator.run(repo, path, :up, all: true)
end

Ecto.Adapters.SQL.Sandbox.mode(ScrollexEcto.TestRepo, :manual)
