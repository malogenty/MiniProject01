defmodule ApiProjectWeb.Router do
  use ApiProjectWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", ApiProjectWeb do
    pipe_through(:api)
    get("/users", UserController, :list)
    get("/users/:userId", UserController, :read)
    get("/users/:userId/teams", UserController, :list_user_teams)
    post("/users", UserController, :create)
    put("/users/:userId", UserController, :update)
    delete("/users/:userId", UserController, :delete)

    get("/workingtimes/:userId", WorkingTimeController, :readAll)
    get("/workingtimes/:userId/:id", WorkingTimeController, :readOne)
    post("/workingtimes/:userId", WorkingTimeController, :create)
    put("/workingtimes/:id", WorkingTimeController, :update)
    delete("/workingtimes/:id", WorkingTimeController, :delete)

    get("/hoursworked", HoursWorkedController, :index)
    get("/hoursworked/:user_id", HoursWorkedController, :getByUser)
    post("/hoursworked/:user_id", HoursWorkedController, :create)
    put("/hoursworked/:id", HoursWorkedController, :update)
    delete("/hoursworked/:id", HoursWorkedController, :delete)

    get("/clocks/:userId", ClockController, :read)
    post("/clocks/:userId", ClockController, :create)

    get("/teams/:teamId", TeamController, :read)
    get("/teams/:teamId/users", TeamController, :list_team_users)
    post("/teams", TeamController, :create)
    post("/teams/associate_user", TeamController, :create_relation)
    put("/teams/:teamId", TeamController, :update)
    delete("/teams/:teamId", TeamController, :delete)
    delete("/teams/:teamId/:userId", TeamController, :delete_relation)
  end
end
