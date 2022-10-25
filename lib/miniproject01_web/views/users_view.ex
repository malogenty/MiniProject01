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

  def render("error.json", %{reason: reason}) do
    %{
      error: reason
    }
  end
end
