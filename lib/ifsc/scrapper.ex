defmodule Ifsc.Scrapper do
  @url "https://www.rbi.org.in/Scripts/bs_viewcontent.aspx?Id=2009"

  def links do
    %HTTPoison.Response{body: html} = HTTPoison.get!(@url)
    html
    |> Floki.find("#example-min > div > table > tr:nth-child(2) > td > table > tr > td > a")
    |>
      Enum.map(
        fn(a_element) ->
          Floki.attribute(a_element, "a", "href")
          |> List.first
          |> String.replace("http:", "https:")
          |> String.replace(".xlsx", ".xls")
        end
      )
  end
end
