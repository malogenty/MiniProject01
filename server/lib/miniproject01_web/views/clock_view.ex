defmodule ApiProjectWeb.ClockView do
  use ApiProjectWeb, :view
  alias ApiProjectWeb.ClockView

  def render("clock.json", %{clock: clock}) do
    %{
      id: clock.id,
      time: clock.time,
      status: clock.status
    }
  end

  def render("clocks.json", %{clocks: clocks}) do
    for clock <- clocks do
      %{
        id: clock.id,
        time: clock.time,
        status: clock.status
      }
    end
  end

  def render("hours_worked.json", %{hours_worked: hours_worked}) do
    %{
      id: hours_worked.id,
      date: hours_worked.date,
      normal_hours: hours_worked.normal_hours,
      night_hours: hours_worked.night_hours,
      overtime_hours: hours_worked.overtime_hours,
      overtime_night: hours_worked.overtime_night_hours,
      expected_worked_hours: hours_worked.expected_worked_hours,
      user: hours_worked.user_id
    }
  end

  def render("hours_worked_mutliple.json", %{hours_worked_multiple: hours_worked_multiple}) do
    for hours_worked <- hours_worked_multiple do
      %{
        id: hours_worked.id,
        date: hours_worked.date,
        normal_hours: hours_worked.normal_hours,
        night_hours: hours_worked.night_hours,
        overtime_hours: hours_worked.overtime_hours,
        overtime_night: hours_worked.overtime_night_hours,
        expected_worked_hours: hours_worked.expected_worked_hours,
        user: hours_worked.user_id
      }
    end
  end

  def render("error.json", %{reason: reason}) do
    %{
      error: reason
    }
  end

  def render("message.json", %{message: message}) do
    %{
      message: message
    }
  end
end
