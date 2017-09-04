defmodule IfscWeb.BankView do
  use IfscWeb, :view

  def render("index.json", %{bank: bank}) do
    %{
      bank_name: bank.bank_name,
      ifsc: bank.ifsc,
      micr: bank.micr,
      branch: bank.branch,
      address: bank.address,
      contact: bank.contact,
      city: bank.city,
      district: bank.district,
      state: bank.state
    }
  end

end
