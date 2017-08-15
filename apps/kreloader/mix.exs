defmodule Katalyst.Reloader.Mixfile do
  use Mix.Project

  @version "1.0.0-rc1"

  def project, do: [
    app: :kreloader,
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

  def application, do: [
    extra_applications: [:logger],
    mod: {Katalyst.Reloader, []}
  ]

  defp deps, do: [
    {:kcore, in_umbrella: true},
  ]

  defp package, do: [
    licenses: ["Apache 2.0"],
    maintainers: ["Richard Kemp"],
    links: %{
      "GitHub" => "https://github.com/sylv3r/kreloader"
    }
  ]

  defp description do
    """
    Katalyst Reloader helps projects to recompile on the fly files from
    specified directories.
    """
  end
end
