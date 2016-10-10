defmodule Web.History.DailyControllerTest do
  use Web.ConnCase

  setup do
    {:ok, _feeding} = Business.BabyBottle.add({{2016, 10, 4}, {18, 20, 10}}, 60)
    {:ok, _feeding} = Business.BabyBottle.add({{2016, 10, 3}, {18, 23, 10}}, 40)
    {:ok, _feeding} = Business.BabyBottle.add({{2016, 10, 4}, {18, 48, 10}}, 10)

    {:ok, _change} = Business.Diaper.add({{2016, 10, 4}, {18, 28, 10}}, {true, false})
    {:ok, _change} = Business.Diaper.add({{2016, 10, 3}, {18, 31, 10}}, {true, true})
    {:ok, _change} = Business.Diaper.add({{2016, 10, 4}, {18, 22, 10}}, {false, true})
    {:ok, _change} = Business.Diaper.add({{2016, 10, 4}, {18, 36, 10}}, {true, true})

    :ok
  end

  test "show: when user is not authenticated", %{conn: conn} do
    conn = get(conn, daily_path(conn, :show, "2016-10-04"))

    assert 401 == conn.status
  end

  test "show: when date is not valid", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth
      |> get(daily_path(conn, :show, "bad-date"))

    assert 422 == conn.status
  end

  test "show: when date is linked to some feeding or changes", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth
      |> get(daily_path(conn, :show, "2016-10-04"))

    {:ok, response} = Poison.decode(conn.resp_body)

    assert 200 == conn.status
    assert "2016-10-04" == response["date"]
    assert 5 == length(response["history"])
    assert ["feeding", "change", "change", "change", "feeding"] == Enum.map(response["history"], &(&1["type"]))
  end

  test "show: when date is not linked to any feeding or changes", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth
      |> get(daily_path(conn, :show, "2016-10-02"))

    {:ok, response} = Poison.decode(conn.resp_body)

    assert 200 == conn.status
    assert "2016-10-02" == response["date"]
    assert 0 == length(response["history"])
  end
end
