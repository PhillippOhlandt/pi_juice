defmodule PiJuice.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :pi_juice,
      version: @version,
      name: "PiJuice",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      docs: docs(),
      package: package(),
      source_url: "https://github.com/PhillippOhlandt/pi_juice",
      homepage_url: "https://github.com/PhillippOhlandt/pi_juice"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    PiJuice is an Elixir library to talk to the "Pi Supply PiJuice" uninterruptible power supply board.
    """
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:circuits_i2c, "~> 0.3.8 or ~> 1.0"},
      {:dialyxir, "~> 1.2", only: [:dev], runtime: false}
    ]
  end

  defp package do
    %{
      maintainers: ["Phillipp Ohlandt"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/PhillippOhlandt/pi_juice"}
    }
  end

  defp docs do
    [
      main: "PiJuice",
      source_ref: @version,
      source_url: "https://github.com/PhillippOhlandt/pi_juice",
      extras: extras()
    ]
  end

  defp extras do
    [
      "CHANGELOG.md"
    ]
  end
end
