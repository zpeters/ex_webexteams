defmodule ExWebexteams.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_webexteams,
      version: "0.1.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      docs: [
        main: "ExWebexteams",
        extras: ["README.md"]
      ],
      deps: deps(),
      description: description(),
      package: package(),
      homepage_url: "https://github.com/zpeters/ex_webexteams",
      source_url: "https://github.com/zpeters/ex_webexteams"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    "Webex Teams library for Elixir."
  end

  defp package() do
    [
      licenses: ["GPL v3.0"],
      links: %{
        "GitHub" => "https://github.com/zpeters/ex_webexteams",
        "Webex Teams API" => "https://developer.webex.com/"
      }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_rated, "~> 1.3.2"},
      {:poison, "~> 4.0.1"},
      {:httpoison, "~> 1.3.1"},
      {:excoveralls, "~> 0.10.1", only: :test},
      {:elixir_mock, "~> 0.2.8", only: :test},
      {:credo, "~> 0.10.2", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19.1", only: :dev, runtime: false}
    ]
  end
end
