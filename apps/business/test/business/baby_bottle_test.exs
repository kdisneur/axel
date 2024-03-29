defmodule Business.BabyBottleTest do
  use ExUnit.Case

  alias Business.BabyBottle

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Business.Repo)
  end

  test "add: when quantity is positive" do
    assert {:ok, _feeding} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 60)
  end

  test "add: when quantity is negative" do
    assert {:error, _reason} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, -40)
  end

  test "add: when quantity is zero" do
    assert {:error, _reason} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 0)
  end

  test "daily_consumption: when date is linked to some baby bottles" do
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 60)
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 3}, {18, 28, 10}}, 40)
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 10)

    assert 70 == BabyBottle.daily_consumption({2016, 10, 4})
  end

  test "daily_consumption: when date is not linked to any baby bottles" do
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 60)
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 3}, {18, 28, 10}}, 40)
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 10)

    assert 0 == BabyBottle.daily_consumption({2016, 10, 2})
  end

  test "daily_history: when date is linked to some baby bottles" do
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 60)
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 3}, {18, 28, 10}}, 40)
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 10)

    assert 2 == length(BabyBottle.daily_history({2016, 10, 4}))
  end

  test "daily_history: when date is not linked to any baby bottles" do
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 60)
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 3}, {18, 28, 10}}, 40)
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 10)

    assert 0 == length(BabyBottle.daily_history({2016, 10, 2}))
  end

  test "delete: when feeding exists" do
    {:ok, feeding} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 60)
    {:ok, _feeding} = BabyBottle.delete(feeding.id)
  end

  test "delete: when feeding doesn't exist" do
    {:ok, _feeding} = BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 60)
    {:error, :not_found} = BabyBottle.delete(42)
  end
end
