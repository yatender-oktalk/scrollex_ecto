defmodule ScrollexEctoTest do
  use ExUnit.Case
  doctest ScrollexEcto

  alias ScrollexEcto.TestRepo

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TestRepo)
  end

  test "paginate/2 with offset pagination" do
    # Add your test for offset pagination here
  end

  test "paginate/2 with cursor pagination" do
    # Add your test for cursor pagination here
  end
end
