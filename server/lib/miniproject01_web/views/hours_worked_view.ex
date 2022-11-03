defmodule ApiProjectWeb.HoursWorkedView do
  use ApiProjectWeb, :view
  alias ApiProjectWeb.HoursWorkedView

  def render("index.json", %{hours_worked: hours_worked}) do
    for h <- hours_worked do
      %{
        id: h.id,
        date: h.date,
        normal_hours: h.normal_hours,
        night_hours: h.night_hours,
        overtime_hours: h.overtime_hours,
        expected_worked_hours: h.expected_worked_hours,
        user: h.user_id
      }
    end
  end

  def render("show.json", %{hours_worked: hours_worked}) do
    %{
      id: hours_worked.id,
      date: hours_worked.date,
      normal_hours: hours_worked.normal_hours,
      night_hours: hours_worked.night_hours,
      overtime_hours: hours_worked.overtime_hours,
      expected_worked_hours: hours_worked.expected_worked_hours,
      user: hours_worked.user_id
    }
  end

  def render("error.json", %{reason: reason}) do
    %{
      error: reason
    }
  end
end
