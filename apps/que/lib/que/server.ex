defmodule Que.Server do
  use GenServer

  alias Que.Persistence

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:push, item}, state) do
    {:noreply, [item | state]}
  end



  #### client API ####

  def add_to_que(persistance) do
    __MODULE__
    |> GenServer.cast({:push, persistance})
  end

  def persists(term) do
    Persistence.insert(term)
  end
end
