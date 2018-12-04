defmodule Pg do
  @moduledoc """
  Documentation for Pg.
  """
  import Ecto.Changeset
  import Ecto.Query

  alias Pg.Repo
  alias Pg.Schema.Que, as: Schema

  def get_all_jobs do
    from(job in Schema)
    |> Repo.all()
  end

  def insert(term) do
    %Schema{}
      |> cast(%{
        term: term
      }, [:term])
      |> Repo.insert()
  end

  def update(task_id, :task_start) do
    Repo.get_by(Schema, id: task_id)
      |> cast(%{task_start: NaiveDateTime.utc_now()}, [:task_start])
      |> Repo.update()
  end

  def update(task_id, :task_done) do
    Repo.get!(Schema, task_id)
    |> Repo.delete()
  end

  def update(task_id, {:task_failure, reason}) do
    Repo.get_by(Schema, id: task_id)
      |> cast(%{failed_reason: reason}, [:failed_reason])
      |> Repo.update()
  end

  def cleanup() do
    Repo.delete_all(Schema)
    :ok
  end
end
