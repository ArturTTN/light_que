defmodule Que.Server do
  use GenServer

  alias Que.Persistence

  @doc """
  In case if DB will connect with a delay

  """
  @persistance_delay if Mix.env() == :test, do: 0, else: :timer.seconds(5)

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    Process.send_after(self(), :populate_tasks, @persistance_delay)
    {:ok, state}
  end

  @doc """
  Populate task from DB to the state, collect all tasks

  """
  def handle_info(:populate_tasks, state) do
    Persistence.get_all_jobs()
    |> Enum.map(&add_to_que/1)

    {:noreply, state}
  end

  def handle_cast({:push, item}, state) do
    {:noreply, [item | state]}
  end

  @doc """
  Run task, update status in DB, and run async and no link Task

  """
  def handle_cast({:run, {id, term} = task}, state) do
    item =
      case Persistence.update(id, :task_start) do
        {:ok, persistence} -> Que.Executer.run_task(task)
        _error_update_db -> %{id: id, term: term}
      end

    {:noreply,
     [item | state]
     |> List.flatten()}
  end

  def handle_call(:pop, _from, []), do: {:reply, %{}, []}

  def handle_call(:pop, _from, state) do
    {head, tail} = List.pop_at(state, -1)
    {:reply, head, tail}
  end

  #### client API ####

  def add_to_que(persistance) do
    __MODULE__
    |> GenServer.cast(
      {:push,
       %{
         id: persistance.id,
         term: persistance.term
       }}
    )
  end

  def persists(term) do
    Persistence.insert(term)
  end

  def pop() do
    GenServer.call(__MODULE__, :pop)
  end

  def run(%{id: id, term: term}) do
    __MODULE__
    |> GenServer.cast({:run, {id, term}})
  end

  def run(%{}), do: {:ok, :queue_emtpy}

  @doc """
  Every job suppose to return tuple:
  - {:reject, reason}
  - {:ack}
  - {:ok}
  """
  def check_response({:ack}, persistence) do
    Persistence.update(persistence.id, :task_done)
    []
  end

  def check_response({:reject, reason}, persistence) do
    with {ok, persistence} <- Persistence.update(persistence.id, {:task_failure, reason}) do
      persistence
      |> add_to_que()
    end
  end

  def check_response(:ok, persistence) do
    Persistence.update(persistence.id, :task_done)
    []
  end
end
