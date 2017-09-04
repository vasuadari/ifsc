defmodule IfscWeb.BankController do
  use IfscWeb, :controller
  require Ifsc.Bank
  alias Ifsc.Bank

  def index(conn, %{"ifsc" => ifsc} = _params) do
    case Bank.find_by(ifsc) do
      %Bank{ifsc: ^ifsc} = bank ->
        conn
        |> put_status(200)
        |> render("index.json", %{bank: bank})
      nil ->
        conn
        |> put_status(404)
        |> json(%{status: "Not found"})
    end
  end
end
