defmodule Katalyst.ServerTest do
  use ExUnit.Case
  doctest Katalyst.Server

  test "greets the world" do
    assert Katalyst.Server.hello() == :world
  end
end
