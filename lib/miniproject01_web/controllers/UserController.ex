defmodule ApiProjectWeb.UserController do
  use ApiProjectWeb, :controller
  alias ApiProject.User

  def list(conn, _params) do
    user = User.get_user(1)
    json(conn, user)
  end
end
