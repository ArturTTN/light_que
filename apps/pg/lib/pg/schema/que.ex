defmodule Pg.Schema.Que do
  use Ecto.Schema

  alias Pg.Schema.Term

  schema "job_queue" do
    field(:term, Term)
    field(:task_start, :naive_datetime, default: nil)
    field(:failed_reason, :string, default: "")

    timestamps()
  end
end
