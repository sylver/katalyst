defmodule Katalyst.Server.Endpoint do  
  use Plug.Router
  require Logger

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  # get "/foo" do
  #   send_resp(conn, 201, "bar")
  # end

  match _ do
    send_resp(conn, 404, "oops")
  end
end  