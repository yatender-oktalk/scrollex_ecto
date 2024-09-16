defmodule ScrollexEcto.Paginator do
  @moduledoc """
  Provides pagination functionality for Ecto queries.

  This module implements both offset-based and cursor-based pagination methods.
  """

  import Ecto.Query

  @doc """
  Paginates the given queryable based on the provided parameters.

  ## Parameters

    * `queryable` - The Ecto queryable to paginate
    * `params` - A map of pagination parameters
    * `repo` - The Ecto repo to use for queries
    * `conf` - Configuration options

  ## Returns

    A `ScrollexEcto.Page` struct containing the paginated results.
  """
  def paginate(queryable, params, repo, conf) do
    page_type = Map.get(params, "page_type", "offset")

    case page_type do
      "offset" -> paginate_offset(queryable, params, repo, conf)
      "cursor" -> paginate_cursor(queryable, params, repo, conf)
      _ -> {:error, "Invalid page_type"}
    end
  end

  @doc false
  defp paginate_offset(queryable, params, repo, conf) do
    page_number = Map.get(params, "page", 1)
    page_size = Map.get(params, "page_size", conf[:page_size] || 10)

    total_entries = repo.aggregate(queryable, :count, :id)
    total_pages = max(ceil(total_entries / page_size), 1)

    entries =
      queryable
      |> limit(^page_size)
      |> offset(^((page_number - 1) * page_size))
      |> repo.all()

    %ScrollexEcto.Page{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_pages: total_pages,
      total_entries: total_entries
    }
  end

  @doc false
  defp paginate_cursor(queryable, params, repo, conf) do
    cursor = Map.get(params, "cursor")
    page_size = Map.get(params, "page_size", conf[:page_size] || 10)

    order_field = conf[:order_field] || :inserted_at
    id_field = conf[:id_field] || :id

    queryable =
      queryable
      |> order_by(desc: ^order_field, desc: ^id_field)

    queryable =
      if cursor do
        [last_value, last_id] = decode_cursor(cursor)

        from(q in queryable,
          where:
            field(q, ^order_field) < ^last_value or
              (field(q, ^order_field) == ^last_value and field(q, ^id_field) < ^last_id)
        )
      else
        queryable
      end

    entries =
      queryable
      |> limit(^(page_size + 1))
      |> repo.all()

    {entries, next_cursor} =
      case entries do
        [] ->
          {[], nil}

        [_ | _] = entries when length(entries) <= page_size ->
          {entries, nil}

        [_ | _] = entries ->
          next = List.last(entries)
          {List.delete_at(entries, -1), encode_cursor(next, order_field, id_field)}
      end

    %ScrollexEcto.Page{
      entries: entries,
      next_cursor: next_cursor,
      page_size: page_size
    }
  end

  @doc false
  defp encode_cursor(item, order_field, id_field) do
    [Map.get(item, order_field), Map.get(item, id_field)]
    |> :erlang.term_to_binary()
    |> Base.url_encode64()
  end

  @doc false
  defp decode_cursor(cursor) do
    cursor
    |> Base.url_decode64!()
    |> :erlang.binary_to_term()
  end
end
