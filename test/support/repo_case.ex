defmodule ScrollexEcto.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias ScrollexEcto.TestRepo

      import Ecto
      import Ecto.Query
      import ScrollexEcto.RepoCase

      # You can add any other imports or aliases here
    end
  end

  setup tags do
    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(ScrollexEcto.TestRepo, shared: not tags[:async])
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
    :ok
  end
end
