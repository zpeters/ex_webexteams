defmodule ExWebexteams.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_webexteams,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:ex_rated, "~> 1.3.2"},
      {:poison, "~> 4.0.1"},
      {:httpoison, "~> 1.3.1"}
    ]
  end
end
