defmodule Katalyst.Reloader.WatcherTest do
  use ExUnit.Case, async: true

  alias Katalyst.Reloader.Watcher

  setup do
    path = "/tmp/"
    args = %{paths: ["lib"], silent: false}
    {:ok, watcher} = start_supervised({Watcher, args})
    %{watcher: watcher, path: path}
  end

end
