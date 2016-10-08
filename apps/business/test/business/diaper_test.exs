defmodule Business.DiaperTest do
  use ExUnit.Case

  alias Business.Diaper

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Business.Repo)
  end

  test "add: when contains poop but no pee" do
    {:ok, change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {true, false})

    assert change.poop
    refute change.pee
  end

  test "add: when contains pee but no poop" do
    {:ok, change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {false, true})

    refute change.poop
    assert change.pee
  end

  test "add: when contains pee and poop" do
    {:ok, change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {true, true})

    assert change.poop
    assert change.pee
  end
end
