defmodule ApiProjectWeb.ClockView do
    use ApiProjectWeb, :view
    alias ApiProjectWeb.ClockView
  
    def render("clock.json", %{clock: clock}) do
      %{
        id: clock.user,
        time: clock.time,
        status: clock.status
      }
    end
  
    def render("clocks.json", %{clocks: clocks}) do
      for clock <- clocks do %{
        id: clock.user,
        time: clock.time,
        status: clock.status
      }
      end
    end

    def render("error.json", %{reason: reason}) do
      %{
        error: reason
      }
    end
  end
  