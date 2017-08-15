defmodule Katalyst.Reloader do
  @moduledoc false

  use Application
  
  alias Katalyst.Reloader.Watcher

  def start(_type, _args) do
    config = Application.get_env(:katalyst, Reloader, [])

    if length(config) == 0, do: raise "Katalyst Reloader config is required"

    paths = Keyword.fetch!(config, :paths)
    silent = Keyword.fetch!(config, :silent)
    infinity = Keyword.get(config, :infinity, true)
    
    children = [
      {Watcher, [paths, silent, infinity]}
    ]

    opts = [strategy: :one_for_one, name: Katalyst.Reloader.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
