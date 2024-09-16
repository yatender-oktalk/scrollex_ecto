# ScrollexEcto

ScrollexEcto is a flexible pagination library for Elixir and Ecto, supporting both offset-based and cursor-based pagination.

## Installation

Add `scrollex_ecto` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:scrollex_ecto, "~> 0.1.0+minor"}
  ]
end
```

## Usage
Add ScrollexEcto to your Repo module:
```elixir
defmodule MyApp.Repo do
  use Ecto.Repo,
    otp_app: :my_app,
    adapter: Ecto.Adapters.Postgres

  use ScrollexEcto,
    page_size: 10,
    order_field: :inserted_at,
    id_field: :id
end
```
Then you can use it in your queries:
```elixir
# Offset-based pagination
MyApp.Repo.paginate(MyApp.Item, %{"page" => 2, "page_size" => 20})

# Cursor-based pagination
MyApp.Repo.paginate(MyApp.Item, %{"page_type" => "cursor", "cursor" => "some_cursor", "page_size" => 20})
```

For more detailed usage and configuration options, please refer to the (documentation)[https://hexdocs.pm/scrollex_ecto].

## Author

ScrollexEcto is created and maintained by Yatender Singh Suman.

## License

Copyright (c) 2024 Yatender Singh Suman

ScrollexEcto is released under the MIT License. See the [LICENSE](https://github.com/yatender-oktalk/scrollex_ecto/blob/main/LICENSE) file for details.
