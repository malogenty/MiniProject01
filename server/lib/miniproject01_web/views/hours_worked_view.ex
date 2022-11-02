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
      normal_hours: hours_worked.normal_hours
    }
  end

  def render("error.json", %{reason: reason}) do
    %{
      error: reason
    }
  end
end
