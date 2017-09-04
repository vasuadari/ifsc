defmodule Ifsc.Importer do
  alias Ifsc.CSVParser
  alias Ifsc.Bank

  def import do
    CSVParser.parse_all_entries
    |> Enum.chunk_every(500)
    |> Enum.map(fn(rows) -> Ifsc.Repo.insert_all(Bank, rows) end)
  end
end
