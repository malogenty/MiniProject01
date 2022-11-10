defmodule ApiProjectWeb.ScheduleView do
  use ApiProjectWeb, :view

  def render("list.json", %{schedules: schedules}) do
    for schedule <- schedules do
      %{
        id: schedule.id,
        start: schedule.start,
        duration: schedule.duration,
        user: schedule.user_id,
        title: schedule.title
      }
    end
  end

  def render("schedule.json", %{schedule: schedule}) do
    %{
      id: schedule.id,
      start: schedule.start,
      duration: schedule.duration,
      user: schedule.user_id,
      title: schedule.title
    }
  end

  def render("error.json", %{reason: reason}) do
    %{
      error: reason
    }
  end
end
