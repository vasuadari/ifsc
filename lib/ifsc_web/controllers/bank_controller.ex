defmodule IfscWeb.BankController do
  use IfscWeb, :controller
  require Ifsc.Bank
  alias Ifsc.Bank

  def index(conn, %{"ifsc" => ifsc} = _params) do
    case Bank.find_by(ifsc) do
      %Bank{ifsc: ^ifsc} = bank ->
        conn
        |> put_status(200)
        |> json(%{bank: bank, status: "OK"})
      {:error, _} ->
        conn
        |> put_status(500)
        |> json(%{bank: 0, status: "Error occurred"})
    end
  end
end
