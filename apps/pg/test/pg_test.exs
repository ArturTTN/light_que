defmodule PgTest do
  use ExUnit.Case
  doctest Pg

  test "get_all_jobs" do
    assert Pg.get_all_jobs() == []
  end

  test "insert" do
    {:ok, record} = Pg.insert({IO, :puts, ["HEllo"]})
    assert record.__struct__ == Pg.Schema.Que
  end

  test "delete" do
    assert Pg.delete(1) == :ok
  end

  test "update" do
    assert Pg.update(1, :success) == :ok
  end

end
