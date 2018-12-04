defmodule Pg.Schema.Term do
  @behaviour Ecto.Type

  def type, do: :binary
  def cast(bin), do: {:ok, bin |> :erlang.term_to_binary()}
  def load(bin), do: {:ok, bin |> :erlang.binary_to_term()}
  def dump(bin), do: {:ok, bin |> :erlang.term_to_binary()}
end
