defmodule ApiProjectWeb.UserView do
  use ApiProjectWeb, :view
  alias ApiProjectWeb.UserView

  def render("user.json", %{user: user, token: token}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
      hour_rate: user.hour_rate,
      token: token
    }
  end

  def render("users.json", %{users: users}) do
    for user <- users do
      %{
        id: user.id,
        username: user.username,
        email: user.email,
        role: user.role,
        hour_rate: user.hour_rate
      }
    end
  end

  def render("user_teams.json", %{teams: teams}) do
    for team <- teams do
      %{
        id: team.id,
        name: team.name,
        startOfDay: team.start_of_day,
        endOfDay: team.end_of_day
      }
    end
  end

  def render("error.json", %{reason: reason}) do
    %{
      error: reason
    }
  end
end
