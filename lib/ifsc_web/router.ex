defmodule IfscWeb.Router do
  use IfscWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", IfscWeb do
    pipe_through :api

    resources "/bank", BankController
  end
end
