defmodule Pg.Repo.Migrations.CreateJobQue do
  use Ecto.Migration

  def change do
    create table(:job_queue) do

      add :term, :bytea, null: false
      add :task_start, :naive_datetime
      add :failed_reason, :string, default: ""
      timestamps()
    end
  end
end
