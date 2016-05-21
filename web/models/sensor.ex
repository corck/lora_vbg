defmodule LoraVbg.Sensor do
  use LoraVbg.Web, :model

  schema "sensors" do
    field :name, :string
    field :longitude, :float
    field :latitude, :float
    field :created, Ecto.DateTime

    timestamps
  end

  @required_fields ~w(name longitude latitude created)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
