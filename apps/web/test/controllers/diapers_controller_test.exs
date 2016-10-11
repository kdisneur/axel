defmodule Web.DiapersControllerTest do
  use Web.ConnCase

  test "create: when user is not authenticated", %{conn: conn} do
    conn =
      conn
      |> post(diapers_path(conn, :create), %{changed_at: "2016-09-12 15:30:42",
                                             poop: true,
                                             pee: true})

    assert 401 == conn.status
  end

  test "create: when datetime is valid, and the data contains poop but no pee", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth
      |> post(diapers_path(conn, :create), %{changed_at: "2016-09-12 15:30:42",
                                             poop: true,
                                             pee: false})

    {:ok, response} = Poison.decode(conn.resp_body)

    assert 201 == conn.status
    assert "change" == response["type"]
    assert response["id"]
    assert "2016-09-12T15:30:42" == response["changed_at"]
    assert response["poop"]
    refute response["pee"]
  end

  test "create: when datetime is valid, and the data contains pee but no poop", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth
      |> post(diapers_path(conn, :create), %{changed_at: "2016-09-12 15:30:42",
                                             poop: false,
                                             pee: true})

    {:ok, response} = Poison.decode(conn.resp_body)

    assert 201 == conn.status
    assert "2016-09-12T15:30:42" == response["changed_at"]
    refute response["poop"]
    assert response["pee"]
  end

  test "create: when datetime is valid, and the data contains poop and pee", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth
      |> post(diapers_path(conn, :create), %{changed_at: "2016-09-12 15:30:42",
                                             poop: true,
                                             pee: true})

    {:ok, response} = Poison.decode(conn.resp_body)

    assert 201 == conn.status
    assert "2016-09-12T15:30:42" == response["changed_at"]
    assert response["poop"]
    assert response["pee"]
  end

  test "delete: when user is not authenticated", %{conn: conn} do
    {:ok, change} = Business.Diaper.add({{2016, 10, 4}, {18, 4, 10}}, {true, true})

    conn = delete(conn, diapers_path(conn, :delete, change.id))

    assert 401 == conn.status
  end

  test "delete: when change exists", %{conn: conn} do
    {:ok, change} = Business.Diaper.add({{2016, 10, 4}, {18, 4, 10}}, {true, true})

    conn =
      conn
      |> using_basic_auth
      |> delete(diapers_path(conn, :delete, change.id))

    assert 200 == conn.status
  end

  test "delete: when change doesn't exist", %{conn: conn} do
    {:ok, _feeding} = Business.Diaper.add({{2016, 10, 4}, {18, 4, 10}}, {true, true})

    conn =
      conn
      |> using_basic_auth
      |> delete(diapers_path(conn, :delete, 42))

    assert 422 == conn.status
  end
end
