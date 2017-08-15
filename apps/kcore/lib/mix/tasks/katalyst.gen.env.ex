defmodule Mix.Tasks.Katalyst.Gen.Env do
  @shortdoc "Generates a default .env file"

  @moduledoc ~S"""
  Generates a default .env file.
  The file will be placed in the project root directory.

  ## Examples
      mix katalyst.gen.env
  """

  use Mix.Task

  @app :kcore # shouldn't be hardcoded

  @doc false
  def run(_args) do
    root_path = File.cwd!
    priv_path = :code.priv_dir(@app)

    env_file = Path.join([root_path, ".env"])
    template = Path.join([priv_path, "templates", "default_env.eex"])
    bindings = []

    if File.regular?(env_file) do
      Mix.raise "mix katalyst.gen.env : .env file alrealdy exists"
    end

    Mix.Generator.create_file(env_file, EEx.eval_file(template, bindings))
  end
end