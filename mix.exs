defmodule Shopify.Mixfile do
  use Mix.Project

  def project do
    [app: :shopify,
     version: "0.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.9.0"},
      {:inflex, "~> 1.7.0" },
      {:poison, "~> 2.0"}
    ]
  end
end
