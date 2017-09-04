defmodule Ifsc.CSVParser do
  alias Ifsc.Downloader

  @header [ "BANK", "IFSC", "MICR", "BRANCH", "ADDRESS", "CONTACT", "CITY", "DISTRICT", "STATE" ]

  def parse_all_entries do
    Downloader.download_all
    |> Task.async_stream(Ifsc.CSVParser, :parse_file, [], timeout: 30000)
    |> Enum.to_list
    |> Enum.map(fn({:ok, a}) -> a end)
    |> List.flatten
  end

  def parse_file(file_path) do
    [ header_row | rows ] =
    File.stream!(file_path)
    |> CSV.decode
    |> Enum.map(fn({:ok, a}) -> a end)
    header(header_row)
    Enum.map(
      rows,
      fn(row) ->
        [ bank_name, ifsc, micr, branch, address, contact, city, district, state ] = row
        %{
          bank_name: bank_name,
          ifsc: ifsc,
          micr: micr,
          branch: branch,
          address: address,
          contact: contact,
          city: city,
          district: district,
          state: state
        }
      end
    )
  end

  def header(row) do
    case row do
      [ "BANK", "IFSC", "MICR", "BRANCH", "ADDRESS", "CONTACT", "CITY", "DISTRICT", "STATE" ] -> @header
      [ "BANKNAME", "IFSC", "MICR_CODE", "BRANCH", "ADDRESS", "CONTACT1", "CENTRE", "DISTRICT", "STATE" ] -> @header
      [ "BANK", "IFSC", "MICR CODE", "BRANCH", "ADDRESS", "CONTACT", "CITY", "DISTRICT", "STATE" ] -> @header
      [ "BANK ", "IFSC CODE", "MICR CODE", "BRANCH NAME", "ADDRESS", "CONTACT", "CITY", "DISTRICT", "STATE" ] ->
        @header
    end
  end
end
