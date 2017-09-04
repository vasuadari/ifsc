defmodule Mix.Tasks.Ifsc.ImportFromRbi.Run do
  use Mix.Task

  def run(_args) do
    Mix.Task.run "app.start"
    IO.puts "Started importing IFSC codes from RBI"
    Ifsc.Importer.import
    IO.puts "Completed importing IFSC codes"
  end
end
