defmodule Katalyst.Server.Mixfile do
  use Mix.Project

  @version "1.0.0-rc1"

  def project, do: [
    app: :kserver,
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
    Katalyst Server, as its name hints, handles all the serving capabilities
    of the Katalyst framework.
    It provides endpoints and functions to serve routes on differents protocols
    as channels and websockets.
    """
  end

  def application, do: [
    extra_applications: applications(Mix.env),
    mod: {Katalyst.Server, []}
  ]

  defp applications(:dev), do: applications(:all) ++ [:kreloader]
  defp applications(_all), do: [:logger]

  defp deps, do: [
    {:cowboy,  "~> 1.1.2"},
    {:plug,    "~> 1.4.3"},
    {:corsica, "~> 1.0.0"},
    {:kreloader, in_umbrella: true, only: :dev},
    {:kcore, in_umbrella: true},
  ]
end
