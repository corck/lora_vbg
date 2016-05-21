defmodule LoraVbg.SensorTest do
  use LoraVbg.ModelCase

  alias LoraVbg.Sensor

  @valid_attrs %{created: "2010-04-17 14:00:00", latitude: "120.5", longitude: "120.5", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Sensor.changeset(%Sensor{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sensor.changeset(%Sensor{}, @invalid_attrs)
    refute changeset.valid?
  end
end
