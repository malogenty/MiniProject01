defmodule ApiProjectWeb.Router do
  use ApiProjectWeb, :router
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiProjectWeb do
    pipe_through :api
    scope "/users", UserController, as: :users do
    end
    scope "/workingtimes", WorkingTimesController, as: :workingtimes do
    end
    scope "/clocks", ClocksController, as: :clocks do
      get "/", ClocksController, :read
    end
  end

end
