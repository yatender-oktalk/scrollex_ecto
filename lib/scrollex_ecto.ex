defmodule ScrollexEcto do
  @moduledoc """
  ScrollexEcto is a pagination library for Ecto queries.

  It provides both offset-based and cursor-based pagination methods.
  """

  @doc """
  A macro that injects pagination functionality into the using module.

  ## Options

  The `opts` parameter can include:
    * `:page_size` - The default number of items per page (default: 10)
    * `:order_field` - The field to use for ordering in cursor-based pagination (default: :inserted_at)
    * `:id_field` - The ID field to use as a tie-breaker in cursor-based pagination (default: :id)

  ## Example

      defmodule MyRepo do
        use Ecto.Repo, otp_app: :my_app
        use ScrollexEcto, page_size: 20
      end
  """
  defmacro __using__(opts) do
    quote do
      @scrollex_conf unquote(opts)

      @doc """
      Paginates the given queryable.

      ## Parameters

        * `queryable` - The Ecto queryable to paginate
        * `params` - A map of pagination parameters (default: %{})

      ## Returns

        A `ScrollexEcto.Page` struct containing the paginated results.
      """
      def paginate(queryable, params \\ %{}) do
        ScrollexEcto.paginate(queryable, params, __MODULE__, @scrollex_conf)
      end
    end
  end

  @doc """
  Paginates the given queryable using the ScrollexEcto.Paginator.

  This function is called by the injected `paginate/2` function and shouldn't be used directly.
  """
  def paginate(queryable, params, repo, conf) do
    ScrollexEcto.Paginator.paginate(queryable, params, repo, conf)
  end
end
