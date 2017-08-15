defmodule Katalyst.Server do
  @moduledoc false

  use Application
  
  require Logger

  alias Katalyst.Server.Endpoint
  alias Katalyst.Core.Utils, as: CoreUtils

  @doc false
  def start(_type, _args) do
    #TODO: Better protection on missing config vars
    config = Application.get_env(:katalyst, Server, [])
    port = config |> Keyword.get(:port, 8080) |> CoreUtils.cast_string
    ssl = config |> Keyword.get(:ssl, false) |> CoreUtils.cast_string
    scheme = ssl && :https || :http
    router = config |> Keyword.fetch!(:router)

    children = [
      Plug.Adapters.Cowboy.child_spec(scheme, router, [], [port: port])
    ]

    opts = [strategy: :one_for_one, name: Katalyst.Server.Supervisor]
    status = Supervisor.start_link(children, opts)
    
    case status do
      {:ok, _pid} ->
        Logger.info(" Running Katalyst Server on port #{port} ...", [])
      {:error, _error} ->
        Logger.error("Unable to start Katalyst Server", [])
    end
    status
  end
end
