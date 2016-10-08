defmodule Web.Stats.BabyBottle.DailyConsumptionControllerTest do
  use Web.ConnCase

  setup do
    {:ok, _feeding} = Business.BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 60)
    {:ok, _feeding} = Business.BabyBottle.add({{2016, 10, 3}, {18, 28, 10}}, 40)
    {:ok, _feeding} = Business.BabyBottle.add({{2016, 10, 4}, {18, 28, 10}}, 10)

    :ok
  end

  test "show: when user is not authenticated", %{conn: conn} do
    conn = get(conn, daily_consumption_path(conn, :show, "2016-10-04"))

    assert 401 == conn.status
  end

  test "show: when date is not valid", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth
      |> get(daily_consumption_path(conn, :show, "bad-date"))

    assert 422 == conn.status
  end

  test "show: when date is linked to some baby bottles", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth
      |> get(daily_consumption_path(conn, :show, "2016-10-04"))

    {:ok, response} = Poison.decode(conn.resp_body)

    assert 200 == conn.status
    assert "2016-10-04" == response["date"]
    assert 70 == response["consumption"]["quantity"]
    assert "ml" == response["consumption"]["unit"]
  end

  test "show: when date is not linked to some baby bottles", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth
      |> get(daily_consumption_path(conn, :show, "2016-10-02"))

    {:ok, response} = Poison.decode(conn.resp_body)

    assert 200 == conn.status
    assert "2016-10-02" == response["date"]
    assert 0 == response["consumption"]["quantity"]
    assert "ml" == response["consumption"]["unit"]
  end
end
