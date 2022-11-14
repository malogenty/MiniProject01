defmodule ApiProjectWeb.TeamView do
  use ApiProjectWeb, :view

  def render("team.json", %{team: team}) do
    %{
      id: team.id,
      name: team.name,
      startOfDay: team.start_of_day,
      endOfDay: team.end_of_day,
      nightMultiplicator: team.night_multiplicator,
      overtimeMultiplicator: team.overtime_multiplicator
    }
  end

  def render("teams.json", %{teams: teams}) do
    for team <- teams do
      %{
        id: team.id,
        name: team.name,
        startOfDay: team.start_of_day,
        endOfDay: team.end_of_day,
        nightMultiplicator: team.night_multiplicator,
        overtimeMultiplicator: team.overtime_multiplicator
      }
    end
  end

  def render("teams_users.json", %{users: users}) do
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

  def render("error.json", %{reason: reason}) do
    %{
      error: reason
    }
  end
end
