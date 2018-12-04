defmodule PgTest do
  use ExUnit.Case
  doctest Pg

  test "insert" do
    {:ok, record} = Pg.insert({IO, :puts, ["HEllo"]})
    assert record.__struct__ == Pg.Schema.Que
  end
end
