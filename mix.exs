defmodule KatalystFramework.Mixfile do
  use Mix.Project

  def project, do: [
    build_path: System.get_env("BUILD_PATH") || "_build",
    deps_path: System.get_env("DEPS_PATH") || "_deps",
    config_path: "config/config.exs",
    apps_path: "apps",
    elixirc_paths: elixirc_paths(Mix.env),
    lockfile: "mix.lock",
    elixir: "~> 1.5",
    start_permanent: Mix.env == :prod,
    deps: deps()
  ]

  # Run "mix help compile.app" to learn about applications.
  def application, do: [
    extra_applications: [:logger]
  ]

  # Common paths to use in all elixirc_paths method definitions
  defp common_paths, do: ["apps"]
  defp elixirc_paths(_), do: common_paths()

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps, do: []
end
