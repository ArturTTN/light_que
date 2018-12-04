defmodule Que.Server do
  use GenServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end




  #### client API ####

  def add_to_que(persistance) do
    {:ok}
  end

  def persists(term) do
    {:ok, %{}}
  end
end
