defmodule ApiProjectWeb.ScheduleView do
  use ApiProjectWeb, :view

  def render("list.json", %{schedules: schedules}) do
    for schedule <- schedules do
      %{
        id: schedule.id,
        start: schedule.start,
        end: schedule.end,
        user: schedule.user_id,
        title: schedule.title
      }
    end
  end

  def render("error.json", %{reason: reason}) do
    %{
      error: reason
    }
  end
end
