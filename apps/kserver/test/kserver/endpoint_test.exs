defmodule Katalyst.Server.EndpointTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Katalyst.Server.Endpoint

  @moduletag :capture_log

  @opts Endpoint.init([])

  doctest Endpoint

  test "returns hello world" do
    # Create a test connection
    conn = conn(:get, "/hello")

    # Invoke the plug
    conn = Endpoint.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "world"
  end
end
