defmodule LoraVbg.Repo.Migrations.AddFieldsToSensors do
  use Ecto.Migration

  def change do
    alter table(:sensors) do
      add :noise, :float
    end
  end
end
