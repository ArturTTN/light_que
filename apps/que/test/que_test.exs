defmodule QueTest do
  use ExUnit.Case
  doctest Que

  test "add new job. success" do
    assert Que.add({IO, :puts, ["Hello"]}) == {:ok, :queued_up}
  end

  test "add new job. no params" do
    assert_raise ArgumentError, fn ->
      Que.add()
    end
  end

  test "put in que and check order of jobs" do
    Que.add({IO, :puts, ["Hello"]})
    Que.add({IO, :puts, ["Buy"]})
    %{id: id_hello} = Que.Server.pop()
    %{id: id_buy} = Que.Server.pop()
    assert id_hello < id_buy
  end

  test "an empty state" do
    Que.add({IO, :puts, ["Hello"]})
    Que.Server.pop()
    assert Que.get() == {:ok, :queue_emtpy}
  end
end
