defmodule PageFetcher.MixProject do
  use Mix.Project

  def project do
    [
      app: :page_fetcher,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:floki, "~> 0.34.0"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      {:mox, "~> 1.0", only: :test}
    ]
  end
end
