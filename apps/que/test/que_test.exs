defmodule QueTest do
  use ExUnit.Case
  doctest Que

  test "add new job. success" do
    assert Que.add({IO, :puts, ["Hello"]}) == :ok
  end

  test "add new job. no params" do
    assert_raise ArgumentError, fn ->
      Que.add()
    end
  end
end
