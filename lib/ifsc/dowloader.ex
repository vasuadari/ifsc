defmodule Ifsc.Downloader do
  alias Ifsc.Scrapper

  def download_all do
    Scrapper.links
    |> Task.async_stream(Ifsc.Downloader, :download_and_convert_to_csv, [], timeout: 30000)
    |> Enum.to_list
    |> Enum.map(fn({:ok, file_path}) -> file_path end)
  end

  def download_and_convert_to_csv(url) do
    IO.puts url
    file_name = url |> String.split("/") |> List.last
    file_path = "/tmp/#{Date.to_string(Date.utc_today)}_#{file_name}"
    csv_file_path = csv_file_path(file_path)
    if not File.exists?(csv_file_path) do
      body =
        case HTTPoison.get!(url) do
          %HTTPoison.Response{body: body, status_code: 404} ->
            IO.puts "404"
            download_and_convert_to_csv(String.replace(url, ".xls", ".xlsx"))
          %HTTPoison.Response{body: body, status_code: 200} -> body
            File.write!("/tmp/#{Date.to_string(Date.utc_today)}_#{file_name}", body)
            convert_to_csv(file_path)
        end
    end
    csv_file_path
  end

  def convert_to_csv(file_path) do
    IO.puts file_path
    csv_file_path = csv_file_path(file_path)
    "in2csv #{file_path} > #{csv_file_path} && rm #{file_path}" |> String.to_charlist |> :os.cmd
    csv_file_path
  end

  def csv_file_path(file_path) do
    [ base_path | _ ] = String.split(file_path, ".")
    "#{base_path}.csv"
  end
end
