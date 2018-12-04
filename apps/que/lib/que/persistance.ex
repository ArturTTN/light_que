defmodule Que.Persistence do
  #
  # Here we may put adapter from config,
  # either from environment variable of the node
  # in future if needed
  #
  @adapter Application.get_env(:que, :persistance)

  @doc """
  Find all jobs from the db.
  """
  defdelegate get_all_jobs(), to: @adapter

  @doc """
  Inserts new task into db.
  Returns new task record
  """
  defdelegate insert(term), to: @adapter

  @doc """
  Update task reason.
  """
  defdelegate update(task_id, reason), to: @adapter

  @doc """
  Delete all tasks. For test purpose
  """
  defdelegate cleanup(), to: @adapter
end
