defmodule Katalyst.Reloader.Watcher do
  @moduledoc """
  """

  use GenServer

  require Logger

  alias Katalyst.Core.Utils, as: CoreUtils

  @poll_threshold 5_000

  ## CLIENT CALLBACKS

  @doc """
  Starts the Watcher.
  """
  def start_link([paths, silent, infinity]) do
    args = %{paths: paths, silent: silent, infinity: infinity}

    {:ok, pid} = GenServer.start_link(__MODULE__, args, name: __MODULE__)
    Process.send(pid, :POLL, [])
    {:ok, pid}
  end

  ## SERVER CALLBACKS

  @doc false
  def init(props) do
    utc = :calendar.universal_time
    history = []
    {:ok, {props, utc, history}}
  end

  def handle_cast({:compile, file}, state) do
    Logger.info "recompilation triggered from #{file} ..."
    reload()
    #TODO: handle proper message depending on reload exit state
    {:noreply, state}
  end

  @doc """
  :POLL message triggers a full scan of directories for new updated content
  """
  def handle_info(:POLL, {props, utc, history} = state) do
    # Logger.info "POLL ..."

    case CoreUtils.scan_mtime(props.paths, utc) do
      {:ok, file, mtime} ->
        GenServer.cast(self(), {:compile, file})
        history = [{file, mtime} | history]
        props.infinity && poll() 
        {:noreply, {props, :calendar.universal_time, history}} 
      _ ->
        props.infinity && poll() 
        {:noreply, state}
    end
  end
  
  defp reload() do
    Mix.Task.reenable("compile.elixir")
    Mix.Task.run("compile.elixir")
  end

  defp poll() do
    Process.send_after(self(), :POLL, @poll_threshold)
  end
end