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
end
