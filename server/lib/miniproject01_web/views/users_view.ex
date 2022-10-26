defmodule ApiProjectWeb.UserView do
  use ApiProjectWeb, :view
  alias ApiProjectWeb.UserView

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email
    }
  end

  def render("users.json", %{users: users}) do
    for user <- users do %{
      id: user.id,
      username: user.username,
      email: user.email
    }
    end
  end

  def render("error.json", %{reason: reason}) do
    %{
      error: reason
    }
  end
end
