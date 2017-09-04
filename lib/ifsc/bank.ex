defmodule Ifsc.Bank do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
  alias Ifsc.Bank
  alias Ifsc.Repo

  schema "ifsc_banks" do
    field :address, :string
    field :bank_name, :string
    field :branch, :string
    field :city, :string
    field :contact, :string
    field :district, :string
    field :ifsc, :string
    field :micr, :string
    field :state, :string

    timestamps()
  end

  @doc false
  def changeset(%Bank{} = bank, attrs) do
    bank
    |> cast(attrs, [:bank_name, :ifsc, :micr, :branch, :address, :contact, :city, :district, :state])
    |> validate_required([:bank_name, :ifsc, :micr, :branch, :address, :contact, :city, :district, :state])
  end

  def create(attrs) do
    bank =
      %Bank{}
      |> cast(attrs, [:bank_name, :ifsc, :micr, :branch, :address, :contact, :city, :district, :state])
    Repo.insert(bank)
  end

  def find_by(ifsc) do
    query = from b in Bank, where: b.ifsc == ^ifsc
    Repo.one(query)
  end
end
