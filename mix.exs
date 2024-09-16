defmodule ScrollexEcto.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/yatender-oktalk/scrollex_ecto"

  def project do
    [
      app: :scrollex_ecto,
      version: @version,
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "ScrollexEcto",
      source_url: @source_url,
      docs: docs(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ScrollexEcto.Application, []}
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.12"},
      {:ecto_sql, "~> 3.12"},
      {:postgrex, ">= 0.0.0", only: :test},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp description do
    "A flexible pagination library for Elixir and Ecto supporting both offset-based and cursor-based pagination."
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Yatender Singh Suman"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/scrollex_ecto",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
