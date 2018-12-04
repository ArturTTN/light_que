defmodule Que.Executer do
  @doc """
  Que Executer is needed for long running tasks,
  for no blocking process

  """
  def run({id, term}) do

    {mod, fun, args} = :erlang.binary_to_term(term)

    apply(mod, fun, args)
    |> Que.Server.check_response(%{id: id, term: term})
  end

  #### client API ###

  def run_task({id, term} = task) do

    case Task.start(Que.Executer, :run, [task]) do
      {:ok, _} -> []
      _        -> %{id: id, term: term}
    end
  end
end