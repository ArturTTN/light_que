defmodule Pg do
  @moduledoc """
  Documentation for Pg.
  """
  import Ecto.Changeset
  import Ecto.Query

  alias Pg.Repo
  alias Pg.Schema.Que, as: Schema

  def get_all_jobs do
    []
  end

  def insert(term) do
    %Schema{}
      |> cast(%{
        term: term
      }, [:term])
      |> Repo.insert()
  end

  def delete(job_id) do
    :ok
  end

  def update(task_id, reason) do
    :ok
  end

end
