defmodule ApiProjectWeb.UsersView do
  use ApiProjectWeb, :view
  alias ApiProjectWeb.UsersView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UsersView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: users.id,
      username: users.username,
      email: users.email
    }
  end
end
