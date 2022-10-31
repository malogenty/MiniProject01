defmodule ApiProjectWeb.TeamView do
  use ApiProjectWeb, :view

  def render("team.json", %{team: team}) do
    %{
      id: team.id,
      name: team.name,
      startOfDay: team.start_of_day,
      endOfDay: team.end_of_day
    }
  end

  def render("teams.json", %{teams: teams}) do
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
