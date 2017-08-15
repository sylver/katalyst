defmodule Katalyst.Core.Mixfile do
  use Mix.Project

  @version "1.0.0-rc1"

  def project, do: [
    app: :kcore,
    version: @version,
    build_path: System.get_env("BUILD_PATH") || "../../_build",
    deps_path: System.get_env("DEPS_PATH") || "../../_deps",
    config_path: "../../config/config.exs",
    lockfile: "../../mix.lock",
    elixir: "~> 1.5",
    start_permanent: Mix.env == :prod,
    package: package(),
    description: description(),
    deps: deps()
  ]

  defp package, do: [
    licenses: ["Apache 2.0"],
    maintainers: ["Richard Kemp"],
    links: %{
      "GitHub" => "https://github.com/sylv3r/katalyst"
    }
  ]

  defp description do
    """
    Katalyst Core is the main application of the Katalyst framework.
    It sets and starts the main infrastructure and the many dependencies needed
    to run the framework. Every other Katalyst apps depend on it.
    """
  end

  # Run "mix help compile.app" to learn about applications.
  def application, do: [
    extra_applications: applications(Mix.env),
  ]

  # defp applications(:dev), do: applications(:all) ++ [:kreloader]
  defp applications(_all), do: [:logger]

  # Run "mix help deps" to learn about dependencies.
  defp deps, do: []
end
