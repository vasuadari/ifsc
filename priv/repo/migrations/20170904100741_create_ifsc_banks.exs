defmodule Ifsc.Repo.Migrations.CreateIfscBanks do
  use Ecto.Migration

  def change do
    create table(:ifsc_banks) do
      add :bank_name, :string
      add :ifsc, :string
      add :micr, :string
      add :branch, :string
      add :address, :string
      add :contact, :string
      add :city, :string
      add :district, :string
      add :state, :string

      timestamps()
    end

    alter table(:ifsc_banks) do
      modify :inserted_at, :naive_datetime, default: fragment("NOW()")
      modify :updated_at, :naive_datetime, default: fragment("NOW()")
    end
  end
end
