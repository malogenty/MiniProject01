defmodule ApiProjectWeb.Router do
  use ApiProjectWeb, :router
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiProjectWeb do
    pipe_through :api
    get "/users", UserController, :list
    get "/users", UserController, :read
    post "/users", UserController, :create
    put "/users", UserController, :update
    delete "/users", UserController, :delete

    get "/workingtimes", WorkingTimeController, :read
    post "/workingtimes", WorkingTimeController, :create
    put "/workingtimes", WorkingTimeController, :update
    delete "/workingtimes", WorkingTimeController, :delete

    get "/workingtimes", ClockingController, :read
    post "/workingtimes", ClockingController, :create
  end

end
