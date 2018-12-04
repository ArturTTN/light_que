defmodule Que do
  @moduledoc """
  Documentation for Que.
  """

  alias Que.Server

  @add_help_message """
  Que.add requires {mod, fun, args}

  For example, to run Que.long_run(1000000):

  > Que.add({Que, :long_run, [1000000]})
  """

  def add(term = {mod, fun, args}) do
    with {:ok, persistance} <- Server.persists(term),
         :ok                <- Server.add_to_que(persistance) do
      {:ok, :queued_up}
    else
      error -> {:error, error}
    end
  end

  def add(_), do: raise ArgumentError, @add_help_message
  def add(), do: raise ArgumentError, @add_help_message


  def get() do
    Server.pop()
    |> Server.run()
  end



  ### For testing purpose
  def success do
    {:ack}
  end

  def error do
    {:reject, "reason"}
  end

  def long_run(sec) do
    Process.sleep(sec)
    {:ack}
  end
end
