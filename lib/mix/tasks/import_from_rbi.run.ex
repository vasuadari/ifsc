defmodule Mix.Tasks.Ifsc.ImportFromRbi.Run do
  use Mix.Task
  require Logger

  def run(_args) do
    Mix.Task.run "app.start"
    Logger.info "Started importing IFSC codes from RBI"
    Ifsc.Importer.import
    Logger.info "Completed importing IFSC codes"
  end
end
