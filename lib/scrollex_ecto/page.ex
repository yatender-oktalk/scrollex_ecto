defmodule ScrollexEcto.Page do
  @moduledoc """
  Represents a page of results from a paginated query.

  This struct is returned by the `ScrollexEcto.Paginator.paginate/4` function.
  """

  @typedoc """
  Type specification for the ScrollexEcto.Page struct.

  Fields:
    * `:entries` - List of items on the current page
    * `:page_number` - Current page number (for offset-based pagination)
    * `:page_size` - Number of items per page
    * `:total_pages` - Total number of pages (for offset-based pagination)
    * `:total_entries` - Total number of items across all pages (for offset-based pagination)
    * `:next_cursor` - Cursor for the next page (for cursor-based pagination)
  """
  @type t :: %__MODULE__{
          entries: [any()],
          page_number: integer() | nil,
          page_size: integer(),
          total_pages: integer() | nil,
          total_entries: integer() | nil,
          next_cursor: String.t() | nil
        }

  defstruct [:entries, :page_number, :page_size, :total_pages, :total_entries, :next_cursor]
end
