defmodule QueTest do
  use ExUnit.Case
  doctest Que

  test "greets the world" do
    assert Que.hello() == :world
  end
end
