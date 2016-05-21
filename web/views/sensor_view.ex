defmodule LoraVbg.SensorView do
  use LoraVbg.Web, :view

  def render("index.json", %{sensors: sensors}) do
    %{data: render_many(sensors, LoraVbg.SensorView, "sensor.json")}
  end

  def render("show.json", %{sensor: sensor}) do
    %{data: render_one(sensor, LoraVbg.SensorView, "sensor.json")}
  end

  def render("sensor.json", %{sensor: sensor}) do
    %{id: sensor.id,
      name: sensor.name,
      longitude: sensor.longitude,
      latitude: sensor.latitude,
      created: sensor.created}
  end
end
