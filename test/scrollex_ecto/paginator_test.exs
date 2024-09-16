defmodule ScrollexEcto.PaginatorTest do
  use ScrollexEcto.RepoCase
  doctest ScrollexEcto

  alias ScrollexEcto.TestRepo

  defmodule TestSchema do
    use Ecto.Schema

    schema "test_schema" do
      field(:name, :string)
      timestamps()
    end
  end

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TestRepo)

    # Create the table
    Ecto.Adapters.SQL.query!(TestRepo, """
    CREATE TABLE IF NOT EXISTS test_schema (
      id SERIAL PRIMARY KEY,
      name TEXT,
      inserted_at TIMESTAMP,
      updated_at TIMESTAMP
    )
    """)

    # Insert some test data
    for i <- 1..20 do
      TestRepo.insert!(%TestSchema{name: "Test #{i}"})
    end

    on_exit(fn ->
      # Drop the table after tests
      Ecto.Adapters.SQL.query!(TestRepo, "DROP TABLE IF EXISTS test_schema")
    end)

    :ok
  end

  test "paginate/2 with offset pagination" do
    import Ecto.Query

    query = from(t in TestSchema, order_by: [asc: t.id])
    params = %{"page" => 2, "page_size" => 5}
    repo_conf = Application.get_env(:scrollex_ecto, TestRepo)

    result = ScrollexEcto.paginate(query, params, TestRepo, repo_conf)

    assert length(result.entries) == 5
    assert result.page_number == 2
    assert result.page_size == 5
    assert result.total_pages == 4
    assert result.total_entries == 20
  end
end
