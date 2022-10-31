defmodule ApiProjectWeb.WorkingTimeView do
  use ApiProjectWeb, :view

  def render("index.json", %{working_times: working_times}) do
    for working_time <- working_times do
      %{
        id: working_time.id,
        start: working_time.start,
        end: working_time.end,
        user: working_time.user_id
      }
    end
  end

  def render("show.json", %{working_time: working_time}) do
    %{
      id: working_time.id,
      start: working_time.start,
      end: working_time.end,
      user_id: working_time.user_id
    }
  end

  def render("error.json", %{reason: reason}) do
    %{
      error: reason
    }
  end
end
