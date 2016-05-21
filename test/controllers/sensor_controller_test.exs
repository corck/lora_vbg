defmodule LoraVbg.SensorControllerTest do
  use LoraVbg.ConnCase

  alias LoraVbg.Sensor
  @valid_attrs %{created: "2010-04-17 14:00:00", latitude: "120.5", longitude: "120.5", name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sensor_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    sensor = Repo.insert! %Sensor{}
    conn = get conn, sensor_path(conn, :show, sensor)
    assert json_response(conn, 200)["data"] == %{"id" => sensor.id,
      "name" => sensor.name,
      "longitude" => sensor.longitude,
      "latitude" => sensor.latitude,
      "created" => sensor.created}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, sensor_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, sensor_path(conn, :create), sensor: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Sensor, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sensor_path(conn, :create), sensor: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    sensor = Repo.insert! %Sensor{}
    conn = put conn, sensor_path(conn, :update, sensor), sensor: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Sensor, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sensor = Repo.insert! %Sensor{}
    conn = put conn, sensor_path(conn, :update, sensor), sensor: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    sensor = Repo.insert! %Sensor{}
    conn = delete conn, sensor_path(conn, :delete, sensor)
    assert response(conn, 204)
    refute Repo.get(Sensor, sensor.id)
  end
end
