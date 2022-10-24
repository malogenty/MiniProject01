defmodule ApiProjectWeb.Router do
  use ApiProjectWeb, :router
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiProjectWeb do
    pipe_through :api
    get "/users", UserController, :list
    get "/users/:userId", UserController, :read
    post "/users/", UserController, :create
    put "/users/:userId", UserController, :update
    delete "/users/:userId", UserController, :delete

    get "/workingtimes/:userId", WorkingTimeController, :read
    get "/workingtimes/:userId/:id", WorkingTimeController, :read
    post "/workingtimes/:userId", WorkingTimeController, :create
    put "/workingtimes/:id", WorkingTimeController, :update
    delete "/workingtimes/:id", WorkingTimeController, :delete

    get "/clocks/:userId", ClockingController, :read
    post "/clocks/:userId", ClockingController, :create
  end

end
