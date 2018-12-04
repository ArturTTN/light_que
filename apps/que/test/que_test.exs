defmodule QueTest do
  use ExUnit.Case
  doctest Que

  setup do
    Que.Persistence.cleanup
  end

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

  test "populate state after crash" do


    Que.add({IO, :puts, ["Hello"]})
    Que.add({IO, :puts, ["Hello"]})

    pid = Process.whereis(Que.Server)
    Process.exit(pid, :kill)

    Process.sleep(1000)

    %{id: id_hello} = Que.Server.pop()
    %{id: id_buy} = Que.Server.pop()
    assert id_hello < id_buy
  end
end
