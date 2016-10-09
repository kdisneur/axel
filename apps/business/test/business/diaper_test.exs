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

  test "daily_poop_count: when date is linked to some diapers containing poop" do
    {:ok, _change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {true, false})
    {:ok, _change} = Diaper.add({{2016, 10, 3}, {18, 28, 10}}, {false, true})
    {:ok, _change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {true, false})
    {:ok, _change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {false, true})

    assert 2 == Diaper.daily_poop_count({2016, 10, 4})
  end

  test "daily_poop_count: when date is linked to some diapers which doesn't contain poop" do
    {:ok, _change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {true, false})
    {:ok, _change} = Diaper.add({{2016, 10, 3}, {18, 28, 10}}, {false, true})
    {:ok, _change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {true, false})
    {:ok, _change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {false, true})

    assert 0 == Diaper.daily_poop_count({2016, 10, 2})
  end

  test "daily_pee_count: when date is linked to some diapers containing pee" do
    {:ok, _change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {true, false})
    {:ok, _change} = Diaper.add({{2016, 10, 3}, {18, 28, 10}}, {false, true})
    {:ok, _change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {true, false})
    {:ok, _change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {false, true})

    assert 1 == Diaper.daily_pee_count({2016, 10, 4})
  end

  test "daily_pee_count: when date is linked to some diapers which doesn't contain pee" do
    {:ok, _change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {true, false})
    {:ok, _change} = Diaper.add({{2016, 10, 3}, {18, 28, 10}}, {false, true})
    {:ok, _change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {true, false})
    {:ok, _change} = Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {false, true})

    assert 0 == Diaper.daily_pee_count({2016, 10, 2})
  end
end
