defmodule LoraVbg.SensorController do
  use LoraVbg.Web, :controller

  alias LoraVbg.Sensor

  plug :scrub_params, "sensor" when action in [:create, :update]

  def index(conn, _params) do
    sensors = Repo.all(Sensor)
    render(conn, "index.json", sensors: sensors)
  end

  def create(conn, %{"sensor" => sensor_params}) do
    changeset = Sensor.changeset(%Sensor{}, sensor_params)

    case Repo.insert(changeset) do
      {:ok, sensor} ->
        conn
        |> put_status(:created)
        #|> put_resp_header("location", sensor_path(conn, :show, sensor))
        |> render("show.json", sensor: sensor)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LoraVbg.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sensor = Repo.get!(Sensor, id)
    render(conn, "show.json", sensor: sensor)
  end

  def update(conn, %{"id" => id, "sensor" => sensor_params}) do
    sensor = Repo.get!(Sensor, id)
    changeset = Sensor.changeset(sensor, sensor_params)

    case Repo.update(changeset) do
      {:ok, sensor} ->
        render(conn, "show.json", sensor: sensor)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LoraVbg.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sensor = Repo.get!(Sensor, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sensor)

    send_resp(conn, :no_content, "")
  end
end
