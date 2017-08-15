defmodule Katalyst.Core.Utils do
  @moduledoc """
  TODO: Write Katalyst.Core.Utils moduledoc
  """

  require Logger

  @boolean_true_terms ~w(true yes 1)
  @boolean_false_terms ~w(false no 0)

  @doc """
  Convert a string to its primitive type.

  Types supported :

    * integer
    * float 
    * boolean
  
  If a value isn't castable, the string is returned, unchanged.

  ## Example

    iex> Katalyst.Core.Utils.cast_string("42")
    42
    iex> Katalyst.Core.Utils.cast_string("3.14159")
    3.14159
    iex> Katalyst.Core.Utils.cast_string("true")
    true
    iex> Katalyst.Core.Utils.cast_string("No")
    false
    iex> Katalyst.Core.Utils.cast_string("pi is 3.14159")
    "pi is 3.14159"

  """
  @spec cast_string(String.t):: integer | float | boolean | String.t
  def cast_string(term) when is_binary(term) do
    cond do
      Regex.match?(~r/^\d+$/, term) -> String.to_integer(term)
      Regex.match?(~r/^\d+.\d+$/, term) -> String.to_float(term)
      String.downcase(term) in @boolean_true_terms -> true
      String.downcase(term) in @boolean_false_terms -> false
      true -> term
    end
  end
  def cast_string(term), do: term

  @type operator :: :gt | :lt | :get | :let
  @type date :: {year :: integer, month :: integer, day :: integer}
  @type time :: {hours :: integer, minutes :: integer, seconds :: integer}
  @type datetime :: {date, time}

  @doc """
  """
  @spec scan_mtime([String.t], datetime) :: {:ok, datetime, String.t} | nil
  def scan_mtime([path | paths], date_ref) do
    cond do
      File.dir?(path) ->
        case File.ls!(path)
        |> Enum.map(&Path.join(path, &1))
        |> scan_mtime(date_ref) do
          {:ok, path, mtime} -> {:ok, path, mtime}
          _ -> scan_mtime(paths, date_ref)
        end
      File.regular?(path) ->
        mtime = File.stat!(path, []).mtime
        if compare_dates?(:gt, mtime, date_ref), do: {:ok, path, mtime},
          else: scan_mtime(paths, date_ref)
      true ->
        nil
    end
  end
  def scan_mtime([], _), do: :not_found

  @doc """
  Compare 2 dates based on the operator symbol. 
  Date should be in the tupple format provided by the `:calendar` module.
  
  ## Example:
  
    iex> date1 = {{1970, 01, 01}, {12, 00, 00}}
    iex> date2 = {{2017, 08, 01}, {12, 00, 00}}
    iex> Katalyst.Core.Utils.compare_dates?(:gt, date1, date2)
    false
    iex> Katalyst.Core.Utils.compare_dates?(:lt, date1, date2)
    true
  """
  @spec compare_dates?(operator, datetime, datetime) :: boolean 
  def compare_dates?(:gt, date, date_ref) when date > date_ref, do: true 
  def compare_dates?(:get, date, date_ref) when date >= date_ref, do: true 
  def compare_dates?(:lt, date, date_ref) when date < date_ref, do: true 
  def compare_dates?(:let, date, date_ref) when date <= date_ref, do: true 
  def compare_dates?(_operator, _date, _date_ref), do: false
end