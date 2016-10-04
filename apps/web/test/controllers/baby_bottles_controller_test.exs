defmodule Web.BabyBottlesControllerTest do
  use Web.ConnCase

  test "create: when datetime and quantity are valid", %{conn: conn} do
    conn = post(conn, baby_bottles_path(conn, :create), %{fed_at: "2016-09-12 15:30:42",
                                                          quantity: 60})

    {:ok, response} = Poison.decode(conn.resp_body)

    assert 201 == conn.status
    assert 60 == response["quantity"]
    assert "2016-09-12T15:30:42" == response["fed_at"]
  end

  test "create: when datetime and quantity is invalid", %{conn: conn} do
    conn = post(conn, baby_bottles_path(conn, :create), %{fed_at: "2016-09-12 15:30:42",
                                                          quantity: -42})

    {:ok, response} = Poison.decode(conn.resp_body)

    assert 422 == conn.status
    assert 1 == length(response["errors"])
    assert "quantity" == Enum.at(response["errors"], 0)["field"]
    assert "must be greater than 0" == Enum.at(response["errors"], 0)["value"]
  end

  test "create: when quantity is not present", %{conn: conn} do
    conn = post(conn, baby_bottles_path(conn, :create), %{fed_at: "2016-09-12 15:30:42"})

    {:ok, response} = Poison.decode(conn.resp_body)

    assert 422 == conn.status
    assert 1 == length(response["errors"])
    assert "quantity" == Enum.at(response["errors"], 0)["field"]
    assert "can't be blank" == Enum.at(response["errors"], 0)["value"]
  end
end
