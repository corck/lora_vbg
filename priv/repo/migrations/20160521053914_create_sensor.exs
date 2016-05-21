defmodule LoraVbg.Repo.Migrations.CreateSensor do
  use Ecto.Migration

  def change do
    create table(:sensors) do
      add :name, :string
      add :longitude, :float
      add :latitude, :float
      add :created, :datetime

      timestamps
    end

  end
end
